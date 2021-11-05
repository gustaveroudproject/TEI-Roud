<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="xs tei" version="1.0">
    <xsl:output method="html" indent="yes" omit-xml-declaration="no" encoding="UTF-8"/>
    
    
    <xsl:template match="/">
        <html>
            <head>
                <script>
                    <xsl:text>
            // When the user clicks on div, open the popup
            function quotePopup() {
            var popup = document.getElementById("a-quote-popup-text");
            popup.classList.toggle("show");
            }
            </xsl:text>
                </script>
                <style>
                    <xsl:text>
                /* The actual popup */
                .quote-popup .quote-popup-text {
                visibility: hidden;
                width: 160px;
                background-color: #555;
                color: #fff;
                text-align: center;
                border-radius: 6px;
                padding: 8px 0;
                position: absolute;
                z-index: 1;
                bottom: 125%;
                left: 50%;
                margin-left: -80px;
                }
                
                /* Popup arrow */
                .quote-popup .quote-popup-text {
                content: "";
                position: absolute;
                top: 100%;
                left: 50%;
                margin-left: -5px;
                border-width: 5px;
                border-style: solid;
                border-color: #555 transparent transparent transparent;
                }
                
                /* Toggle this class - hide and show the popup */
                .quote-popup .show {
                visibility: visible;
                -webkit-animation: fadeIn 1s;
                animation: fadeIn 1s;
                }
                </xsl:text>
                </style>
            </head>
            <body>
                <xsl:apply-templates></xsl:apply-templates>
            </body>
        </html>
    </xsl:template>
    
    <xsl:template match="//tei:quote">
        <span>            
            <xsl:attribute name="class">
                <xsl:text>tei-quote quote-popup</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="(click)">
                <xsl:text>quotePopup()</xsl:text>
            </xsl:attribute>
            <xsl:value-of select="text()"/>    
            
            <span>
                <xsl:attribute name="class">
                    <xsl:text>tei-quote-note quote-popup-text</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="id">
                    <xsl:text>a-quote-popup-text</xsl:text>
                </xsl:attribute>
                <xsl:value-of select="./tei:note"/>
            </span>
            
        </span>
    </xsl:template>
    



    
    
</xsl:stylesheet>