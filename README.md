# TEI-Roud

This repo is for handling of TEI data in the project [Gustave Roud, *Œuvres complètes*](https://www.unil.ch/clsr/home/menuinst/projets-de-recherche/gustave-roud-oeuvres-completes.html) (SNSF Project [157970](http://p3.snf.ch/Project-157970)).

The project webapp is available at https://roud.unil.ch/.

For the project ontologies, see [here](https://github.com/LaDHUL/oeuvres-roud).

### Table of contents

**TEI and Roud**
- The encoding [guidelines](./TEI-encodingGuidelines)
- The TEI encoded [texts](./TEI-texts)

**TEI and Knora (DSP)**
The project uses [Knora](https://dsp.dasch.swiss/) (DSP), which requires a customized mapping to work with XML.
- [Create](./createStandoffMapping) a customized TEI mapping for Knora (DSP)
- [Load](./loadStandoffMapping) the customized TEI mapping into Knora (DSP)
- [Load](./loadTexts) the TEI encoded texts into Knora (DSP)

