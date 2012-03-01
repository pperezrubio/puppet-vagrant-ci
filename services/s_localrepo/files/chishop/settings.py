# This file is under SCM control; do not edit in-place.
#
# main config for the chishop server
import os
import chishop
from chishop.conf.default import *

DEBUG = True
TEMPLATE_DEBUG = True

DATABASE_ENGINE = 'sqlite3'
DATABASE_NAME = os.path.join(os.path.abspath(os.path.dirname(chishop.__file__)), 'devdatabase.db')
DATABASE_USER = ''
DATABASE_PASSWORD = ''
DATABASE_HOST = ''
DATABASE_PORT = ''

HAYSTACK_SEARCH_ENGINE = 'whoosh'
HAYSTACK_SITECONF = 'chishop.search_sites'
HAYSTACK_WHOOSH_PATH = os.path.join(os.path.dirname(chishop.__file__), 'haystack')
