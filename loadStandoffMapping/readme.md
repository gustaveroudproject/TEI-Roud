# Load TEI standoff mapping into Knora (DSP)


## What we need

- Standoff ontology
- Standoff XML mapping
- A JSON description of the mapping
- (optional) XSLT to serve HTML to the browser

More about how to create these files [here](../createStandoffMapping).

The files in this repo are **examples**. For the last version of the mapping used in the project "Gustave Roud. *Œuvres complètes*", see https://github.com/LaDHUL/oeuvres-roud/tree/master/mapping.

## Load the mapping into Knora (DSP)

1. Load the standoff ontology `roudMapping.ttl` into db. Can use `load-standoff-onto.expect`
```bash
./load-standoff-onto.expect http://localhost:7200
```

2. Import the XSLT
```bash
# create env and install deps (first time only)
python3 -m venv env
source env/bin/activate
pip3 install -r requirements.txt
# or just enter in env and launch script
python importXSL.py
```
It will give us back the IRI of the uploaded XSLT.

Add the IRI of the XSLT to the XML mapping, at the beginning of the file in the tag `<defaultXSLTransformation>`.


3. Restart Knora
```bash
make stack-restart-api
```

4. Load the XML mapping. It will give us back the IRI of the mapping, composed by the IRI of the project and the value of the `:mappingHasName` property.
```bash
curl -u root@example.com:test -X POST -F json=@roudMapping.json -F xml=@roudMapping.xml http://localhost:3333/v2/mapping
```

**Attention**. The db cannot store two different mappings with the same name: if we want two of them, we need to change the value of the `:mappingHasName` property when loading the new mapping. 

## More ...

**Developing the mapping**. In the development phase, one may need to test different mappings or update them. Each time a new mapping has to be imported in Knora, it is safer to delete all the project assets (ontologies and data) and restart from scratch, instead of having different versions of the mapping with different names. This is because: 
- the standoff onto is stored in the db together with the rest of the project ontology (that's where we sent it using [load-standoff-onto.expect](load-standoff-onto.expect) here above) and, if we just load a new standoff onto, it will not replace the old one but be added to it, creating duplicates;
- the data contains links to the mapping: each `knora-api:textValueAsXml` also has a `knora-api:textValueHasMapping`, where the value of the latter is the IRI of the mapping.

**Preparing the XSLT**. Check the permissions on the XSLT in the db, if it is not working. In the development phase, one may want to update *only* the XSLT, without changing the mapping. This can be done by editing the local file, stored in the local SIPI dir (Knora renamed it when loading it: to find it, check the filename, associated with the XSLT IRI, in the db). Restart Knora to make it work.

**Resources:**
- *How to create a standoff mapping and test with bulk import* [tutorial](https://github.com/LaDHUL/KnoraBulkStandoffImport)
- Knora (DSP) documentation: [XML to Standoff Mapping](https://docs.dasch.swiss/DSP-API/03-apis/api-v2/xml-to-standoff-mapping/?h=mapping)


