# TEI-Roud

This repo is for handling of TEI data in the project [Gustave Roud, *Œuvres complètes*](https://www.unil.ch/clsr/home/menuinst/projets-de-recherche/gustave-roud-oeuvres-completes.html) (SNSF Project [157970](http://p3.snf.ch/Project-157970)).

The project webapp is available at https://roud.unil.ch/.

For the project ontologies, see [here](https://github.com/LaDHUL/oeuvres-roud).

### Table of contents

**TEI and Roud**
- The encoding [guidelines](./TEI-encodingGuidelines)
- The TEI encoded [texts](./TEI-texts)

**TEI and Knora (DSP)**
- [Create](./createStandoffMapping) a customized TEI mapping for Knora (DSP)
- [Load](./loadStandoffMapping) the customized TEI mapping into Knora (DSP)
- [Load](./loadTexts) the TEI encoded texts into Knora (DSP)


### TEI, Knora, Angular app

**Move to app doc**

The project uses [Knora](https://dsp.dasch.swiss/) (DSP), which requires a customized mapping to work with XML. Knora also hosts a customized XSL transformation (from XML to HTML) attached to the mapping.
In the webapp, the text is retrieved in HTML, thanks to the XSLT. Some styling and processing rules are added directly in the XSL transformation, while others happen in the typescript code (in a specific component or in directives).
