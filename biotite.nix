{ lib
, python3Packages
}:

python3Packages.buildPythonPackage rec {
  pname    = "biotite";
  version  = "0.38.0";

  src = python3Packages.fetchPypi {
    inherit pname version;
    sha256 = "YZTyKB+ebj+zwwZPhRtGrdGXBPxsEd5dKJzaL03PghM=";
  };

  nativeBuildInputs = [ python3Packages.cython ];
  propagatedBuildInputs = with python3Packages; [
    setuptools
    numpy
    matplotlib
    biopython
  ];

  patchPhase = ''
    find src/biotite -name '*.c' | while read f; do
      substituteInPlace "$f" \
        --replace '__pyx_v_d->subarray->shape'  'PyArray_SHAPE((PyArrayObject*)__pyx_v_d)[0]' \
        --replace '__pyx_v_d->shape'             'PyArray_SHAPE((PyArrayObject*)__pyx_v_d)[0]'
    done
  '';

  doCheck = false;

  meta = with lib; {
    description = "A Python package for computational molecular biology";
    homepage    = "https://www.biotite-python.org/";
    license     = licenses.nix-build -E 'with import <nixpkgs> {}; callPackage ./packages/biotite/biotite.nix {}'
mit;
    platforms   = platforms.unix;
  };
}
