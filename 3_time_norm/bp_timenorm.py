"""*Manual meiosis time stager*.


GUI for manually assigning a meiotic stage to
the cells based on the progression of the fraction of cells with a single spot
throughout each experiment. Call
:py:func:`burgess_plots.get_manual_meiosis_time_blind` to run the GUI, and
:py:func:`burgess_plots.get_mmt` to average over the called values, using old
guesstimates to fill in as necessary.



"""
from pathlib import Path
import re
import pickle
import os
import time

import pandas as pd
import numpy as np
import scipy
import statsmodels.stats.proportion as binom
import matplotlib.pyplot as plt
import seaborn as sns	#missing

import bruno_util
import multi_locus_analysis as mla

###############{{{
# manual meiosis time gui

def load_manual_meiosis_times(csv_file='time_norm/manual_meiosis_times_blind.csv'):
    """Returns a Series indexed by movie_columns with our current best guess
    for the actual fraction of the way through meiosis of each of the time
    points."""
    manual_meiosis_times = pd.read_csv(csv_file)
    return manual_meiosis_times.groupby(movie_columns).mean()['meiosis_time_guess']

def get_manual_meiosis_time_blind(paired_counts=None):
    """Simple function to present different pairing fraction progressions along
    with a scale to do some manual "blind" calling of the progression.
    We'll be suggesting the original scale I used when making my BPS 2018
    plots. That is, t3 is the canonical "nadir" time, and the full recovery to
    80% paired should happen at t7, with some "exponential"-ish transitions
    between."""
    if paired_counts is None:
        if os.path.exists('paired_counts.csv'):
            paired_counts = pd.read_csv('paired_counts.csv')
        else:
            df = load_and_augment()
            paired_counts = get_paired_counts(df)
            paired_counts = paired_counts.reset_index()
            paired_counts['meiosis_time'] = paired_counts['meiosis'].map(meiosis_string_to_time)
     # collate all experiments into a list we can draw randomly from
    experiments = list(paired_counts.groupby(experiment_columns))
     # # get rid of labels from groupby, prevent array overwrite by copy

    # set up axes and the "guiding" plot
    fig, axs = plt.subplots(ncols=3)
    xa = np.linspace(-1, 0, 2)
    xe = np.linspace(0, 3, 10)
    xl = np.linspace(3, 7, 15)
    ya = np.array([0.8, 0.8]) # fixed value
    # exponential decay that would bottom out at zero but intersects 0.4 at t3
    # solves the equations {A*exp(k*0) = 0.8, A*exp(k*3) = 0.4}
    ye = 0.8*np.exp(np.log(0.4/0.8)/3*xe)
    # similarly, solves the equations {0.8-A*exp(k*3) = 0.4, 0.8-A*exp(k*5) = # 0.7}
    yl = 0.8 - (16/5)*np.exp(-np.log(2)*xl)
    x = np.concatenate((xa, xe, xl))
    y = np.concatenate((ya, ye, yl))
    axs[0].plot(x, y, 'k-')
    xint = x[x == np.round(x)]
    yint = y[x == np.round(x)]
    axs[0].scatter(xint, yint, c='k', marker='x')
    axs[0].set_xlim(-1.1, 7.1)
    axs[0].set_ylim(0, 1)
    axs[0].set_title('Guide for WT experiments.')
    # now to same thing for lys
    # start at 0.8, drop to 0.2 by t3
    ye = 0.8*np.exp(np.log(0.2/0.8)/3*xe)
    # exponentially increase until t4 at around 0.3, then stay flat
    xl = np.array([3, 4, 5, 6, 7])
    yl = np.array([0.2, 0.3, 0.3, 0.3, 0.3])
    x = np.concatenate((xa, xe, xl))
    y = np.concatenate((ya, ye, yl))
    axs[2].plot(x, y, 'k-')
    xint = x[x == np.round(x)]
    yint = y[x == np.round(x)]
    axs[2].scatter(xint, yint, c='k', marker='x')
    axs[2].set_xlim(-1.1, 7.1)
    axs[2].set_ylim(0, 1)
    axs[2].set_title('Guide for SP experiments.')
    fig.suptitle('Click outside of axes to finish. Click with y<0.2 to mark bad time points.')

    guess = None
    confidence = True
    # setup axes to present a new experiment on every click, and use the x
    # coordinate to extract the estimated meiosis time
    def onclick(event):
        nonlocal guess
        nonlocal confidence
        if event.xdata:
            guess = event.xdata
        else:
            guess = np.nan
        if event.ydata:
            confidence = event.ydata >= 0.2
        print("Click registered coordinate: " + str(guess))
        print("Click marks guess as confident: " + str(confidence))
    cid = fig.canvas.mpl_connect('button_press_event', onclick)

    # set up the output of the randomized "trial", with polling to check if
    # click function has updated the "guess" value
    output_columns = experiment_columns + ['meiosis', 'meiosis_time_guess', 'good_guess']
    output = []
    j = 0
    data = []
    while True:
        if j >= len(data):
            i = np.random.randint(len(experiments))
            label, data = experiments[i]
            if label[1] == 'HET5':
                j = np.inf
                continue
            j = 0
        plt.sca(axs[1])
        plt.cla()
        plot_paired_counts_experiment(data, axs[1])
        axs[1].set_xlim(-1.1, 7.1)
        axs[1].set_ylim(0, 1)
        meiosis_label = data['meiosis'].iloc[j]
        axs[1].set_title(str(label[2]) + ": please label '" + str(label) + str(meiosis_label) + "'") # title is locus + requested label
        plt.pause(1)
        # print("Please enter your guess for the meiotic progression of the time point labeled '" + meiosis_label + "': ")
        # line = sys.stdin.readline()
        # if not line:
        #     break
        # try:
        #     continue
        #     guess = float(line.rstrip())
        # except:
        #     break
        # wait for the value to get filled in by on click event handler
        # print("Please click in guide on your guess for the meiotic progression of the time point labeled '" + meiosis_label + "'")
        guess = None
        confidence = True
        while guess is None:
            plt.pause(0.05)
        if np.isnan(guess):
            break
        output.append(label + (meiosis_label, guess, confidence))
        j += 1
    return pd.DataFrame(output, columns=output_columns).to_csv('time_norm/manual_calls1.csv', sep=',')    #export as csv


def plot_paired_counts_experiment(paired_counts_experiment, ax=None, **kwargs):
    """Plot the results of groupby(bp.experiment_columns) on get_paired_counts
    output."""
    i = np.argsort(paired_counts_experiment['meiosis_time'])
    t = paired_counts_experiment['meiosis_time'].values[i]
    y1 = paired_counts_experiment['confint_min_jeffreys'].values[i]
    y2 = paired_counts_experiment['confint_max_jeffreys'].values[i]
    f = paired_counts_experiment['fraction_paired'].values[i]
    if ax is None:
        fig, ax = plt.subplots()
    ax.errorbar(t, f, np.stack((f-y1, y2-f)), **kwargs)
    return ax

 # end manual meiosis time gui

###############}}}

###############{{{
# loading/munging data

experiment_columns = ['locus', 'genotype', 'exp.rep']
condition_columns = experiment_columns + ['meiosis']
movie_columns = condition_columns
track_columns = condition_columns + ['cell']
cell_columns = track_columns
trajectory_columns = track_columns
# the natural index for Trent's data
spot_columns = track_columns + ['tp.n']
# the natural index for the wait times dataframe
wait_columns = track_columns + ['rank_order']

column_types = {'t': 'int64', 'pipeline_version': 'int64', 'locus': 'str',
                'genotype': 'str', 'exp.rep': 'int64', 'meiosis': 'str',
                'delta': 'int64', 'cnt': 'int64', 'sqs': 'float64',
                'sum': 'float64', 'cvv': 'float64', 'ste': 'float64'}

def meiosis_string_to_time(m):
    if m == 'ta':
        return -1
    try:
        return float(m[1:])
    except:
        raise ValueError('need string of form "tX", where X can be passed to float()')

def load_and_augment(data_file='./data/xyz_conf_okaycells9exp.csv'):
    df = pd.read_csv(data_file)
    df = df.set_index(spot_columns)
    df = add_foci(df)
    df = add_dx(df)
    df['manual_meiosis_time'] = load_manual_meiosis_times()
    # df['pipeline_version'] = 'final only' # deprecated column
    df['distances'] = np.sqrt(np.power(df['X2'] - df['X1'], 2)
                            + np.power(df['Y2'] - df['Y1'], 2)
                            + np.power(df['Z2'] - df['Z1'], 2))
    df.loc[np.isnan(df['distances']), 'distances'] = 0
    df['dot_count'] = np.zeros_like(df['foci'])
    df.loc[df['foci'] == 'unp', 'dot_count'] = 2
    df.loc[df['foci'] == 'pair', 'dot_count'] = 1
    for X in ['X', 'Y', 'Z']:
        df['d'+X] = df[X+'2'] - df[X+'1']
    return df

def add_dx(df):
    for X in ['X', 'Y', 'Z']:
        df['d'+X] = df[X + '2'] - df[X+'1']
        df.loc[~np.isfinite(df['d'+X]), 'd'+X] = 0
        df['abs(d'+X+')'] = np.abs(df['d'+X])
    return df

def add_foci(df):
    foci1 = (np.isfinite(df.X1) & np.isfinite(df.Y1) & np.isfinite(df.Z1))
    foci2 = (np.isfinite(df.X2) & np.isfinite(df.Y2) & np.isfinite(df.Z2))
    notfoci2 = ~((np.isfinite(df.X2) | np.isfinite(df.Y2) | np.isfinite(df.Z2)))
    paired = foci1 & notfoci2
    unpaired = foci1 & foci2
    foci_col = df.observation.copy()
    foci_col[paired] = 'pair'
    foci_col[unpaired] = 'unp'
    foci_col[~(paired | unpaired)] = np.nan
    df['foci'] = foci_col
    return df

def get_paired_counts(df):
    paired_counts = df.groupby(movie_columns)['foci'].value_counts()
    paired_counts.name = 'counts'
    paired_counts = paired_counts.unstack('foci')
    paired_counts['total'] = paired_counts['pair'] + paired_counts['unp']
    def add_conf_int(countsdf):
        imin, imax = binom.proportion_confint(countsdf['pair'], countsdf['total'], 0.05)
        countsdf['confint_min_jeffreys'] = imin
        countsdf['confint_max_jeffreys'] = imax
        return countsdf
    paired_counts = paired_counts.apply(add_conf_int, axis=1)
    paired_counts.pair = paired_counts.pair.astype(int)
    paired_counts.unp = paired_counts.unp.astype(int)
    paired_counts.total = paired_counts.total.astype(int)
    paired_counts['fraction_paired'] = paired_counts.pair/paired_counts.total.astype(float)
    return paired_counts


# end loading/munging data
###############}}}




###############{{{
# keep-in-dataframe functions

def num2name(locus, genotype, meiosis, replicate=None):
    cond = (num2locus(locus), num2genotype(genotype),
                num2meiosis(meiosis))
    if replicate is not None:
        cond = cond + (replicate, )
    return cond

def num2foci(num):
    if num == unbound:
        return 'unp'
    elif num == bound:
        return 'pair'
    elif num == -1:
        return 'sim'
    else:
        return 'NaN'

def locus2num(locus):
    if locus == 'URA3':
        num = 0
    elif locus == 'HET5':
        num = 1
    elif locus == 'LYS2':
        num = 2
    else:
        raise ValueError
    return num

def num2locus(num):
    if num == 0:
        locus = 'URA3'
    elif num == 1:
        locus = 'HET5'
    elif num == 2:
        locus = 'LYS2'
    elif num == -1:
        locus = 'sim'
    else:
        raise ValueError
    return locus

def meiosis2num(meiosis):
    if meiosis[1:] == 'a':
        return -5
    return int(meiosis[1:])

def num2meiosis(num):
    if num == -1:
        return 'sim'
    if num == -5:
        return 'ta'
    return 't' + str(int(num))

def genotype2num(genotype):
    if genotype == 'WT':
        num = 0
    elif genotype == 'SP':
        num = 1
    else:
        raise ValueError
    return num

def num2genotype(num):
    if num == 0:
        genotype = 'WT'
    elif num == 1:
        genotype = 'SP'
    elif num == -1:
        genotype = 'sim'
    else:
        raise ValueError
    return genotype


class Foci:
    bound = 1
    unbound = 2

def foci2num(foci):
    if foci == 'unp':
        return Foci.unbound
    elif foci == 'pair':
        return Foci.bound
    else:
        return np.nan

# a regex to identify trajectories with no internal NaN's
ok_traj = re.compile('n*[12]+n*$')

def char_from_pair(p):
    """For making a string representing a trajectory's paired states over time
    in order to classify trajectories via a regex instead of coding the
    complicated logic directly.

    Takes a single numeric representation of paired state\in(1,2,np.nan) and
    returns the character '1', '2', 'n', resp. """
    if p == 1.0:
        return '1'
    elif p == 2.0:
        return '2'
    else:
        return 'n'

def subtract_t0(cvvs):
    cvv0 = cvvs[cvvs['t'] == 0]['cvv']
    if len(cvv0) > 1:
        raise ValueError('Ambiguous t0, did you groupby the wrong thing?')
    cvvs['cvv_normed'] =  cvvs['cvv']/cvv0.iloc[0]
    cvvs['ste_normed'] = cvvs['ste']/cvv0.iloc[0]
    return cvvs


# end keep-in-dataframe analysis functions
###############}}}


