import subprocess
from setuptools import setup

def version():
  out = subprocess.Popen(['git','describe','--tags'], stdout = subprocess.PIPE, universal_newlines = True)
  out.wait()
  if out.returncode == 0:
    m_version = out.stdout.read().strip()
    version = m_version.split("-")
    if len(version) > 0:
      print(version[0])
      return version[0]
  return "0.0.1" #default version

setup(
    name='tenc',
    version=version(),
    classifiers=[
        'Programming Language :: Python :: 2',
        'Programming Language :: Python :: 3'
    ],
    package_dir={'tenc': 'tenc'},
    packages=['tenc'],
    entry_points={'console_scripts': '10c = tenc.cli:main'},
    license='GPLv3',
    long_description=open('README.md', 'rb').read(),
    author='Maximilian Nickel',
    author_email='mnick@mit.edu',
    use2to3=True
)
