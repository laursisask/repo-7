.PHONY: all

build: setup.py
	python setup.py sdist bdist_wheel

install: setup.py
	pip install -e .

requirements: requirements.txt
	pip install -r requirements.txt

clean:
	rm -rf build dist *.egg-info