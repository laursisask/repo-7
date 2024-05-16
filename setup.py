from setuptools import setup, find_packages

setup(
    name='model_download_package',
    version='0.1',
    description='A package for downloading models',
    packages=find_packages(),
    install_requires=[
        'google-cloud-storage',
        'requests',
        'tqdm',
        'urllib3'
    ],
)

