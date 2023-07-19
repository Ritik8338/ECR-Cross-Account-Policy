# Configuration file for the Sphinx documentation builder.
import os
import sys
# Test Need this so sphinx can find lumache.py. Change is .py files are elsewhere than root.
sys.path.insert(0, os.path.abspath(".."))

# -- Project information

project = 'Coastal'
copyright = '2021'
author = 'Multiple'

release = '0.1'
version = '0.1.0'

# -- General configuration

extensions = [
    'sphinx.ext.duration',
    'sphinx.ext.doctest',
    'sphinx.ext.autodoc',
    'sphinx.ext.autosummary',
    'sphinx.ext.intersphinx',
    'autoapi.extension',
#    'sphinxcontrib.apidoc',
]

autoapi_type = 'python'
autoapi_dirs = ['../../src']

#apidoc_module_dir = '../../src'
#apidoc_output_dir = '.'
#apidoc_excluded_paths = ['tests']
#apidoc_separate_modules = True

templates_path = ['_templates']

# -- Options for HTML output

html_theme = 'sphinx_rtd_theme'

# -- Options for EPUB output


# Add any paths that contain custom static files (such as style sheets) here,
# relative to this directory. They are copied after the builtin static files,
# so a file named "default.css" will overwrite the builtin "default.css".
