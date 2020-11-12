import json

import requests

resourceParams = {
    'restype_id': 'http://www.knora.org/ontology/knora-base#XSLTransformation',
    'label': "XSLT for TEI example",
    'properties': {},
    'project_id': 'http://rdfh.ch/projects/0112'
}

# the name of the file to be submitted
filename = "tei2html.xsl"

# a tuple containing the file's name, its binaries and its mimetype
file = {'file': (filename, open(filename, 'r'),
                 "text/xml; charset=utf-8")}  # use name "file"

# do a POST request providing both the JSON and the binaries
r = requests.post("http://localhost/v1/resources",
                  # use name "json"
                  data={'json': json.dumps(resourceParams)},
                  files=file,
                  auth=('root@example.com', 'test'),
                  proxies={'http': 'http://localhost:3333'})

print("Created XSLTransformation IRI: "+r.json()["res_id"])

print(json.dumps(r.json(), indent=2))