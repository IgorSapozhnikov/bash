# bash
Bash (Unix shell)
## format.sh
Task: Display a list of all the URLs that returned the error code of 50x and total number of this errors.
Input data:
05:17:11 GET /index.html 200
05:17:12 GET /index.html 503
05:17:12 GET /foo.html 404
05:17:13 GET /bat.html 200
05:17:13 GET /bas.html 504
05:17:13 GET /index.html 503
05:17:14 GET /bas.html 200
Output data:
/index.html 2
/bas.html 1
