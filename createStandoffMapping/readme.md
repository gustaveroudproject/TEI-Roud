# Create a TEI standoff mapping for Knora (DSP)


## Requirements
- Having a **TEI ODD** for the set of encoded texts to be imported in Knora. ODD is the TEI schema format; it is a XML-TEI document itself, from which one can generate both documentation (in a variety of formats, like html, latex, etc.) and a schema for document validation (in various formats as well, like relax-ng, dtd, etc.). To know more about TEI ODD have a look at this [tutorial](https://tei-c.org/guidelines/customization/getting-started-with-p5-odds/). An ODD can be generated using the TEI tool [Roma](https://roma2.tei-c.org), where one can specify which elements and attributes are used and how.
- An **XSLT processor**, like Saxon, available for example in the XML editor oXygen, but also as a command line tool.

## How it works
A standoff mapping in Knora (DSP) is defined through a XML document and a corresponding standoff ontology (in .ttl, for example), see the [doc](https://docs-api.dasch.swiss/03-apis/api-v1/xml-to-standoff-mapping/#creating-a-custom-mapping). The XML document should be validated using [mappingXMLToStandoff.xsd](https://github.com/dasch-swiss/knora-api/blob/7efc8960b091ee32cc727857f23ca9d8564e1eae/webapi/src/main/resources/mappingXMLToStandoff.xsd).

Here it is explained **how to generate a basic XML document and standoff ontology from the ODD, using two XSLT transformations**. The generated files should be checked and refined manually as explained here below.

## Process
1. Generate the **XML document** from the ODD, applying [odd2xmlMapping.xsl](odd2xmlMapping.xsl) to the [ODD](TEIexampleODD.xml).
2. In the XML mapping document generated, **check** manually the value of the element `<separatesWords>`, which is always 'false' by default. One possibility is to leave the value to 'false' and then control the rendering using the XSLT associated with the mapping.
3. Create the basic **standoff ontology** from the XML document generated, applying [xmlMapping2standoffOnto.xsl](xmlMapping2standoffOnto.xsl) to the [XML mapping](TEIexampleMapping.xml).
4. In the basic onto generated, **check** manually
	- cardinalities, which are set to 1 by default. From the [doc](https://docs.knora.org/03-apis/api-v1/xml-to-standoff-mapping/#respecting-cardinalities): since an XML attribute may occur once at maximum, it makes sense to make the corresponding standoff property in the ontology required (owl:cardinality of one) or optional (owl:maxCardinality of one), but not allowing it more than once. (The xslt is not capable of generate this, but the info is actually there in the original ODD, in the `@usage` attribute, and it gets lost in the XML mapping .. where to keep it in the XML mapping, if for each attribute one can only specify `<attributeName>`, `<namespace>` and `<propertyIri>`?);
	- check `knora-base:objectDatatypeConstraint`, whose value is `xsd:string` by default, but could be: `xsd:string`, `xsd:integer`, `xsd:boolean`, `xsd:decimal`, `xsd:anyURI` (attention, Knora in fact complains about anything that is not `xsd:string`, so better to leave it like this, even if it is less accurate);
	- one might also want to refine labels and comments.
5. Create a **description file** of the mapping in [TEIexampleMapping.json](TEIexampleMapping.json).

## Resources
- Knora [doc](https://docs.dasch.swiss/DSP-API/03-apis/api-v2/xml-to-standoff-mapping/?h=mapping)
- *How to create a standoff mapping and test with bulk import* [tutorial](https://github.com/LaDHUL/KnoraBulkStandoffImport)


