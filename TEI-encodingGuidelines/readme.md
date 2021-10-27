# Encoding guidelines

body, text

Always remember that we are not encoding a diplomatic transcription, but the critical established text.

Quando linea di ... o fine linea e linea seguente, mettere "………" (3 volte "…"). 

**`<div>`** has attribute `@n` for indicating the unique label, which is the title or incipit to be displayed in the table of contents.

**`<head>`** marks the title of a section and appears at the beginning of that section, inside the corresponding `<div>`. Each `<body>` starts with `<head type="main">`,  before the first `<div>`, corresponding to the title of the critical text given by the editor, which will not be processed but rest available when exporting. Because there might be different types of heads, the attribute `@rend` is used to distinguish them: values of `@rend` can be "p", "h1", "h2", etc.

**`<lg>`** and **`<l>`** are used for poetry.

**`<p>`** indicates paragraphs. Between two paragraphs there is a blank line in the established text. When there is only a line break use `<lb/>`.

**`<lb/>`** is used to mark a carriage return inside a paragraph or a dateline. It carries no attributes. It is used between lines, not at the beginning or at the end.

**`<dateline>`** indicates the dateline which sometimes appears at the end of a text or at the beginning, for example in the diary. In the diary, it can also contain a reference to an event instead of a date, but it will still be encoded as a dateline because it is treated in the same way by the editor (e.g., "R. Th. Bosshard" in 1916). The element carries no attributes.
*It should be rendered as a paragraph, not in italic as in the diary edition (why? probably to differentiate it from the rest). In the originals it appears aligned on the right (but always???), maybe we can do that?

**`<hi>`** is used to identify a segment in italic, or any other segment that has a specific position or visualization, expressed by the attribute `@rend`; possible values are `"italic"`, `"align-center"`, `"align-right"`.

**`<seg>`** is used to identify a segment with should be linked to a segment elsewhere. In this case:
	- it has attribute `@n` for indicating a unique label used for linking; the value of `@n` should consist of the first two or three words of the segment, with no space but underscore between them, no accents nor diacritics and no capital letters. 
	- it has attribute `@corresp` and `@knoraLink` to indicate the corresponding `<seg>` in the same or, most often, another text; `@corresp` takes the URI of the target text, plus the fragment corresponding to the seg to which it points to, e.g. "http://rdfh.ch/0112/n1tj8jX6SWqM02rBCg9LkQ#quelques_endroits"; `@knoraLink` only the IRI of the target text without fragment.


**`<ref>`** indicates the mention of a work (of art, literature or music), by Roud or anyone else. It always has attributes `@target` and `@knoraLink` (same value), also when it points to a work that has no *notice* (descriptive note about the work); in that case, there is a rule in the app in order not to display it as a link (only create link if work?.notice != null), but we don't care about it in the encoding. When it points to an external work, the value of `@target` will be of
- one of the subclasses of `:Work` (might have notice) or
- of `:Publication`;
when it points to Roud's own texts, it can point 
- to `:Manuscript` or
- to `:Publication`.
- Not to `:EstablishedText`, PERCHÉ IN ALCUNI CASI NON CI SARÀ, COME PER GLI AVANT-TEXTES. 
At the moment, it points to subclasses of `:Work`, to `:Manuscript` and to `:Publication` ... to be updated.

**`<quote>`** is used for a citation, with the attribute `@source` and `@knoraLink` pointing to the source, which will probably be an item of class `:Publication`.

**`<persName>`** and **`<placeName>`** are used to indicate a person and a place, and they have the attributes `@ref` and `@knoraLink` to point to a resource of the corresponding class.

Roud's notes are indicated with the element **`<note>`** and the attribute `@resp` with value `"Roud"`. It should occur inside a `<div>`.

**`<add>`** is used to encode addition in the margin, that are transcribed in a footnote in the paper edition. The author is always Roud, so we don't use any attribute. The place (margin, between line, etc.) is not specified.

**`<supplied>`** is used to encode editorial addition to the text, for example the dateline in the diary when absent (the Guidelines suggests not to use `<add>` in this case, even if they are a bit contradictory). 

**`<ex>`** is used for expanding abbreviations

**`<space>`** is used to encode whitespace in the established text. It carries the attribute `@quantity`: 1 corresponds to "espace blanc", 2 to "retrait plus important", 3 to "retrait encore plus important", 4 to "retrait beaucoup plus important, milieu de la ligne".

**`<foreign>`** for words in a language other than French.

**`<list>`** contains any sequence of items organized as a list. Inside, use the element **`<item>`**.
*To be rendered with no style for lists because they already contain the index*.





**Obsolete**: 
`<pb>`. It is used at the beginning of a new page. It has the attribute `@n` for the value of property `roud-oeuvres:hasSeqnum`. For the XML/TEI export, we could add the attribute `@source` pointing to the ARK of the manuscript, because images in Sipi have no ARK; it would correspond to the value of the property `roud-oeuvres:pageIsPartOfManuscript`. And the attribute `@ana` for the value of the property `roud-oeuvres:pageHasName`.





