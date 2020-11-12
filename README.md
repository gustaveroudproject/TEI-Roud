# TEIstandoffMapping

1. Create a TEI standoff mapping for Knora;
2. import it;
3. create a resource using it.

**Resources:**
- Knora [doc](https://docs.knora.org/)
- *How to create a standoff mapping and test with bulk import* [tutorial](https://github.com/LaDHUL/KnoraBulkStandoffImport)


## 1. Create a TEI standoff mapping for Knora

**Requirements:**
- Having a **TEI ODD** for the set of encoded texts to be imported in Knora. ODD is the TEI schema format; it is a XML-TEI document itself, from which one can generate both documentation (in a variety of formats, like html, latex, etc.) and a schema for document validation (in various formats as well, like relax-ng, dtd, etc.). To know more about TEI ODD have a look at this [tutorial](https://tei-c.org/guidelines/customization/getting-started-with-p5-odds/). An ODD can be generated using the TEI tool [Roma](https://roma2.tei-c.org), where one can specify which elements and attributes are used and how in the set of encoded documents.
- An **XSLT processor**, like Saxon, available for example in the XML editor oXygen, but also as a command line tool.

A standoff mapping in Knora is defined through a XML document and a corresponding standoff ontology (in .ttl, for example), see the [doc](https://docs.knora.org/03-apis/api-v1/xml-to-standoff-mapping/#creating-a-custom-mapping). The XML document should be validated using [mappingXMLToStandoff.xsd](https://github.com/dasch-swiss/knora-api/blob/7efc8960b091ee32cc727857f23ca9d8564e1eae/webapi/src/main/resources/mappingXMLToStandoff.xsd).

Here it is explained how to generate a basic XML document and standoff ontology automatically from the ODD, using two XSLT transformations. The generated files should be checked and refined manually as explained here below.

1. Generate the XML document from the ODD, applying [odd2xmlMapping.xsl](odd2xmlMapping.xsl) to the [ODD](TEIexampleODD.xml).
2. In the XML mapping document generated, check manually
	- the value of the element `<separatesWords>`, which is always 'false' by default. One possibility is to leave the value to 'false' and then control the rendering using the XSLT associated with the mapping, see here below;
	- add the IRI of the XSLT associated with the mapping, if any. See the [doc](https://docs.knora.org/03-apis/api-v2/tei-xml/): the mapping can have a XSLT associated, for example to produce HTML from TEI or the contrary, depending on the mapping and on what the client is expecting. The IRI of the XSLT should be specified in the `<defaultXSLTransformation>` element; the IRI is obtained loading the XSLT into Knora, for example using [importXSL.py](importXSL.py). 
3. Create the basic standoff ontology from the XML document generated, applying [xmlMapping2standoffOnto.xsl](xmlMapping2standoffOnto.xsl) to the [XML mapping](TEIexampleMapping.xml).
4. In the basic onto generated, check manually
	- cardinalities, which are set to 1 by default. From the [doc](https://docs.knora.org/03-apis/api-v1/xml-to-standoff-mapping/#respecting-cardinalities): since an XML attribute may occur once at maximum, it makes sense to make the corresponding standoff property in the ontology required (owl:cardinality of one) or optional (owl:maxCardinality of one), but not allowing it more than once. (The xslt is not capable of generate this, but the info is actually there in the original ODD, in the `@usage` attribute, and it gets lost in the XML mapping .. where to keep it in the XML mapping, if for each attribute one can only specify `<attributeName>`, `<namespace>` and `<propertyIri>`?);
	- check `knora-base:objectDatatypeConstraint`, whose value is `xsd:string` by default, but could be: `xsd:string`, `xsd:integer`, `xsd:boolean`, `xsd:decimal`, `xsd:anyURI`;
	- one might also want to refine labels and comments.
5. Create description file of this mapping in [TEIexampleMapping.json](TEIexampleMapping.json).


## 2. Import the mapping in Knora

1. Load the standoff onto into db using [load-standoff-onto.expect](load-standoff-onto.expect): 
```bash
./load-standoff-onto.expect http://localhost:7200
```

2. Restart Knora
```bash
make stack-restart-api
```

3. Load the XML mapping. It will give us back the IRI of the mapping, composed by the IRI of the project and the value of the `:mappingHasName` property. Attention: the db cannot store two different mappings with the same name, need to change the value of the `:mappingHasName` property each time.
```bash
curl -u root@example.com:test -X POST -F json=@TEIexampleMapping.json -F xml=@TEIexampleMapping.xml http://localhost:3333/v2/mapping
```

**More on developing the mapping workflow**. In the development phase, one may need to test different mappings or update them. Each time a new mapping has to be imported in Knora, it is safer to delete all the project assets (ontologies and data) and restart from scratch. This is because: 
- the standoff onto is stored in the db together with the rest of the project ontology (that's where we sent it using [load-standoff-onto.expect](load-standoff-onto.expect) here above) and, if we just load a new standoff onto, it will not replace the old one but be added to it, creating duplicates and confusion;
- the data contains links to the mapping: each `knora-api:textValueAsXml` also has a `knora-api:textValueHasMapping`, where the value of the latter is the IRI of the mapping retrieved in point 2.4 here above. But as said above, it is not possible to upload twice a mapping with the same name. Therefore we can change name each time we load a new mapping or delete everything and re-load the updated mapping with the same name without changing the link in the data.
- To delete everything and reload everything:
	- in the Knora local dir, delete ontologies and data and load everything specified in *graphdb-knora-test-data.expect*, using `make init-db-test`;
	- in the project local dir, load ontologies and lists, probably using a customized *load-onto-and-data.expect*;
	- goes back to 2.2 here above.

**More on the XSLT default transformation**. Check the permissions on the XSLT in the db, if it is not working. In the development phase, one may want to update *only* the XSLT, without changing the mapping. This can be done by editing the local file, stored in the local SIPI dir; Knora renamed it when loading it: to find it, check the filename, associated with the XSLT IRI, in the db. Once you find it, edit, save and restart Knora to make it work.



## 3. Create a resource that uses the mapping

Alternatives:
- Knora bulk import, see https://github.com/LaDHUL/KnoraBulkStandoffImport#prepare-bulk-import
- HTTP POST, see https://docs.knora.org/03-apis/api-v2/editing-values/#creating-a-value and in particular https://docs.knora.org/03-apis/api-v2/editing-values/#creating-a-text-value-with-standoff-markup.

