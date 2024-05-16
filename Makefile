.PHONY: install requirements upload clean

REPOSITORY=testpypi

dist:
	python3 -m build

install: setup.py
	pip install -e .

requirements: requirements.txt
	pip install -r requirements.txt

upload: dist
	twine upload \
		--repository ${REPOSITORY} \
		dist/*

clean:
	rm -rf build dist *.egg-info