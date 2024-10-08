{
  lib,
  buildPythonPackage,
  fetchPypi,
  setuptools,
  legacy-cgi,
  pytestCheckHook,
  pythonAtLeast,
  pythonOlder,
}:

buildPythonPackage rec {
  pname = "webob";
  version = "1.8.7";
  pyproject = true;

  disabled = pythonOlder "3.7";

  src = fetchPypi {
    pname = "WebOb";
    inherit version;
    hash = "sha256-tk71FBvlWc+t5EjwRPpFwiYDUe3Lao72t+AMfc7wwyM=";
  };

  build-system = [ setuptools ];

  # https://github.com/Pylons/webob/issues/437
  dependencies = lib.optionals (pythonAtLeast "3.13") [ legacy-cgi ];

  nativeCheckInputs = [ pytestCheckHook ];

  pythonImportsCheck = [ "webob" ];

  disabledTestPaths = [
    # AttributeError: 'Thread' object has no attribute 'isAlive'
    "tests/test_in_wsgiref.py"
    "tests/test_client_functional.py"
  ];

  meta = with lib; {
    description = "WSGI request and response object";
    homepage = "https://webob.org/";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
