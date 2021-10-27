<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="2.0">
    <xsl:output method="text" indent="no" omit-xml-declaration="yes" encoding="UTF-8"/>



    <xsl:template match="/">
        <xsl:text>@prefix owl: &lt;http://www.w3.org/2002/07/owl#&gt; .
        @prefix rdf: &lt;http://www.w3.org/1999/02/22-rdf-syntax-ns#&gt; .
        @prefix xml: &lt;http://www.w3.org/XML/1998/namespace&gt; .
        @prefix xsd: &lt;http://www.w3.org/2001/XMLSchema#&gt; .
        @prefix rdfs: &lt;http://www.w3.org/2000/01/rdf-schema#&gt; .
        @prefix knora-base: &lt;http://www.knora.org/ontology/knora-base#&gt; .
        @prefix salsah-gui: &lt;http://www.knora.org/ontology/salsah-gui#&gt; .
        @prefix roud-oeuvres: &lt;http://www.knora.org/ontology/0112/roud-oeuvres#&gt; .
        @base &lt;http://www.knora.org/ontology/0112/roud-oeuvres&gt; .
        @prefix : &lt;http://www.knora.org/ontology/0112/roud-oeuvres#&gt; .&#xa;&#xa;</xsl:text>
            
            <xsl:apply-templates select="//mappingElement"/>
    </xsl:template>



    <xsl:template match="//mappingElement">
        
        <!-- DECLARE STANDOFF CLASSES -->
        
        <!-- declare class -->
        <xsl:text>roud-oeuvres:</xsl:text>
        <xsl:value-of select="substring-after(./standoffClass/classIri,'#')"></xsl:value-of>
        <xsl:text>&#09;rdf:type&#09;owl:Class ;</xsl:text>
        <!-- declare subclass -->
        <xsl:text>&#xa;&#09;rdfs:subClassOf&#09;knora-base:</xsl:text>
        <xsl:choose>
            <xsl:when test="./standoffClass/datatype">
                <xsl:value-of select="substring-after(./standoffClass/datatype/type,'#')"></xsl:value-of>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text>StandoffTag</xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        <!-- declare attributes, if any -->
        <xsl:if test="./standoffClass/attributes">
            <xsl:for-each select="./standoffClass/attributes/attribute">
                <xsl:variable name="propertyName" select="substring-after(./propertyIri,'#')"/>
                <xsl:text> ,&#xa;&#09;&#09;&#09;[rdf:type&#09;owl:Restriction ;&#xa;&#09;&#09;&#09;owl:onProperty&#09;:</xsl:text>
                <xsl:value-of select="$propertyName"></xsl:value-of>
                <xsl:text> ;&#xa;&#09;&#09;&#09;owl:cardinality "1"^^xsd:nonNegativeInteger ]</xsl:text>
            </xsl:for-each>
        </xsl:if>        
        <!-- declare label and comment -->
        <xsl:text> ;&#xa;&#09;rdfs:label "</xsl:text>
        <xsl:value-of select="./tag/name"/>
        <xsl:text>"@en ;</xsl:text>
        <xsl:text>&#xa;&#09;rdfs:comment "</xsl:text>
        <xsl:value-of select="./tag/name"/>
        <xsl:text>"@en .</xsl:text>
        <xsl:text>&#xa;&#xa;</xsl:text> <!-- line breaks -->
        
        
        <!-- DECLARE STANDOFF PROPERTIES -->
        
        <xsl:if test="./standoffClass/attributes">
            <xsl:for-each select="./standoffClass/attributes/attribute">
                <xsl:variable name="propertyName" select="substring-after(./propertyIri,'#')"/>
                <!-- declare property type -->
                <xsl:text>roud-oeuvres:</xsl:text>
                <xsl:value-of select="$propertyName"></xsl:value-of>
                <xsl:text>&#09;rdf:type&#09;owl:DatatypeProperty ;</xsl:text>
                <!-- declare property label and comment -->
                <xsl:text>&#xa;&#09;rdfs:label "</xsl:text>
                <xsl:value-of select="./attributeName"/>
                <xsl:text>"@en ;</xsl:text>
                <xsl:text>&#xa;&#09;rdfs:comment "</xsl:text>
                <xsl:value-of select="./attributeName"/>
                <xsl:text>"@en ;</xsl:text>
                <!-- declare property subjectClassConstraint and objectDatatypeConstraint -->
                <xsl:text>&#xa;&#09;knora-base:subjectClassConstraint :</xsl:text>
                <xsl:value-of select="substring-after(../../classIri, '#')"/>
                <xsl:text>;&#xa;&#09;knora-base:objectDatatypeConstraint xsd:string .&#xa;&#xa;</xsl:text>
            </xsl:for-each>
        </xsl:if>
        
        
    </xsl:template>
    
</xsl:stylesheet>
