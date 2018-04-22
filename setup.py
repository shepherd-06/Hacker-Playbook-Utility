# Always prefer setuptools over distutils
from setuptools import setup, find_packages
# To use a consistent encoding
from codecs import open
from os import path

here = path.abspath(path.dirname(__file__))

# Get the long description from the README file
with open(path.join(here, 'README.md'), encoding='utf-8') as f:
    long_description = f.read()

# Arguments marked as "Required" below must be included for upload to PyPI.
# Fields marked as "Optional" may be commented out.

setup(
    # $ pip install sampleproject
    name='HP-Utility',  # Required

    version='0.0.3rev3',  # Required

    description='Python Script with bash to install. ',  # Required
    long_description=long_description,  # Optional

    long_description_content_type='text/markdown',  # Optional (see note above)

    url='https://github.com/ibtehaz-shawon/Hacker-Playbook-Utility',  # Optional

    author='Ibtehaz Shawon',  # Optional

    author_email='ibtehaz.shawon@gmail.com',  # Optional

    classifiers=[  # Optional
        # How mature is this project? Common values are
        #   3 - Alpha
        #   4 - Beta
        #   5 - Production/Stable
        'Development Status :: 3 - Alpha',

        # Indicate who your project is intended for
        'Intended Audience :: Developers',
        'Topic :: Software Development :: Build Tools',

        # Pick your license as you wish
        'License :: OSI Approved :: Apache Software License',

        # Specify the Python versions you support here. In particular, ensure
        # that you indicate whether you support Python 2, Python 3 or both.
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.4',
        'Programming Language :: Python :: 3.5',
        'Programming Language :: Python :: 3.6',
        'Operating System :: POSIX :: Linux',
        'Operating System :: POSIX :: BSD',
        'Operating System :: POSIX :: BSD :: FreeBSD',
        'Operating System :: POSIX :: BSD :: NetBSD',
        'Operating System :: POSIX :: BSD :: OpenBSD',
    ],
    keywords='Setup tool for The Hacker Playbook',  # Optional
    py_modules=["HP-Utility"],
    packages=find_packages(exclude=['contrib', 'docs', 'tests']),  # Required
    install_requires=['peppercorn', 'distro'],  # Optional
    entry_points={  # Optional
        'console_scripts': [
            'HP-Utility=HP-Utility:main',
        ],
    },
    project_urls={  # Optional
        'Bug Reports': 'https://github.com/ibtehaz-shawon/Hacker-Playbook-Utility/issues',
        'Source': 'https://github.com/ibtehaz-shawon/Hacker-Playbook-Utility/',
    },
)
