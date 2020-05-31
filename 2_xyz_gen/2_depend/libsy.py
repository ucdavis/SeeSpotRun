
import warnings
warnings.filterwarnings('ignore')

import os
from pathlib import Path
import pathlib
import subprocess
import itertools
import re
import collections
import datetime
import glob
import time
import gc
import sys
sys.stdout.flush()

import multi_locus_analysis as mla
from multi_locus_analysis import fitting
from multi_locus_analysis import finite_window as fw

import pandas as pd
pd.set_option('mode.chained_assignment', None)
import numpy as np
from numpy import nan as Nan
np.seterr(all=None)

import math
from decimal import Decimal
import random

import scipy.io
import scipy
from scipy.optimize import curve_fit
from scipy import stats


import imageio
import imageio.core.util
def silence_imageio_warning(*args, **kwargs):
    pass
imageio.core.util._precision_warn = silence_imageio_warning
from PIL import Image, ImageEnhance

import h5py

import matplotlib.pyplot as plt
from matplotlib.pyplot import figure, draw
from matplotlib.ticker import NullFormatter
from matplotlib.pyplot import imshow
import seaborn as sns
import prettyplotlib as ppl

from statsmodels.stats.proportion import proportion_confint
from statsmodels.stats.proportion import multinomial_proportions_confint


import pickle
import functools
from functools import partial
import imp
import multiprocessing

import matplotlib as mpl
sns.set()
import statsmodels.stats.proportion as binom



