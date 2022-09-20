# Encoding guidelines


## Preamble

The text to encode is the critical edition, not a diplomatic transcription.

Metadata that generally go into the TEI-Header are not included in the encoded texts, as they are recorded in the project data-base.

## TEI encoding
In alphabetical order.

**`<add>`** is used to encode addition in the margin, that are transcribed in a footnote in the paper edition. The author is always Roud, so we don't use any attribute. The place (margin, between line, etc.) is not specified.

**`<dateline>`** indicates the dateline which sometimes appears at the end of a text or at the beginning, for example in the diary. In the diary, it can also contain a reference to an event instead of a date, but it will still be encoded as a dateline because it is treated in the same way by the editor (e.g., "R. Th. Bosshard" in 1916). The element carries no attributes.

**`<div>`** has attribute `@n` for indicating the unique label, which is the title or incipit to be displayed in the table of contents and can contain multiple words. A `<div>` cannot contain directly texts, but should include a paragraph or verse.

**`<ex>`** is used for expanding abbreviations.

**`<foreign>`** for words in a language other than French.

**`<gap>`** indicates an illegible word. It always has the attribute `@reason="illegible"`.

**`<head>`** marks the title of a section and appears at the beginning of that section, inside the corresponding `<div>`. Each `<body>` starts with `<head type="main">`,  before the first `<div>`, corresponding to the title of the critical text given by the editor, which will not be processed but rest available when exporting. Because there might be different types of heads, the attribute `@rend` is used to distinguish them: values of `@rend` can be "p", "h1", "h2", etc.

**`<hi>`** is used to identify a segment in italic, or any other segment that has a specific position or visualization, expressed by the attribute `@rend`; possible values are `"italic"` (rendered inline) and `"align-center"`, `"align-right"`, `"align-left"` (all rendered as a block).

**`<item>`**. They are rendered without a style, because the index is generally already in the text.

**`<lb/>`** is used to mark a carriage return inside a paragraph or a dateline. It carries no attributes. It is used between lines, not at the beginning or at the end.

**`<lg>`** and **`<l>`** are used for verse.

**`<list>`** contains any sequence of items organized as a list. Inside, use the element 

**`<note>`** occurs inside `<quote>` and carries the attribute `@type="quote"`, when it contains info about a citation (corresponding to the print edition footnote, which includes the source but also information about the correctness of the quote). Roud's notes, on the other side, are indicated with the element **`<note>`** and the attribute `@resp` with value `"Roud"`; they should occur inside a `<div>`.

**`<p>`** indicates paragraphs. Between two paragraphs there is a blank line in the established text. When there is only a line break use `<lb/>`.

**`<persName>`** and **`<placeName>`** are used to indicate a person and a place, and they have the attributes `@ref` and `@knoraLink` to point to a resource of the corresponding class. Each person and place that appears in the text (not in a note) and that should be present in the index of names, has to be tagged.

**`<quote>`** is used for a citation. It should contain a `<note>` indicating the source and other info (see `<note>`). Attribute `@rend` is mandatory, possible values are `inline` or `block` (no need to use block when it contains verses in `<lg>`, it would be block anyway).

**`<ref>`** indicates the mention of a work (of art, literature or music), by Roud or anyone else. It always has attributes `@target` and `@knoraLink` (same value), also when it points to a work that has no *notice* (descriptive note about the work); in that case, there is a rule in the app in order not to display it as a link (only create link if work?.notice != null), but we don't care about it in the encoding. When it points to an external work, the value of `@target` will be of
- one of the subclasses of `:Work` (IRI) or
- of `:Publication` (IRI);
when it points to Roud's own texts, it can point 
- to `:Manuscript` (`ms___IRI`) or
- to `:Publication` (`pub___IRI)`
- (not to `:EstablishedText`, because sometime it won't exist, as for the avant-textes).

**`<seg>`** is used to identify a segment with should be linked to a segment elsewhere. In this case:
	- it has attribute `@n` for indicating a unique label used for linking; the value of `@n` should consist of the first two or three words of the segment, with no space but underscore between them, no accents nor diacritics and no capital letters. 
	- it has attribute `@corresp` and `@knoraLink` to indicate the corresponding `<seg>` in the same or, most often, another text; `@corresp` takes the URI of the target text, plus the fragment corresponding to the seg to which it points to, e.g. "http://rdfh.ch/0112/n1tj8jX6SWqM02rBCg9LkQ#quelques_endroits"; `@knoraLink` only the IRI of the target text without fragment.

**`<space>`** is used to encode whitespace in the established text. It carries the attribute `@quantity`: 1 corresponds to "espace blanc", 2 to "retrait plus important", 3 to "retrait encore plus important", 4 to "retrait beaucoup plus important, milieu de la ligne".

**`<supplied>`** is used to encode editorial addition to the text, for example the dateline in the diary when absent (the Guidelines suggests not to use `<add>` in this case, even if they are a bit contradictory). 

**`<unclear>`** indicates readings that are not sure, for any possible reason but mostly because they are hardly legible. It does not feature any attribute.



## Other criteria
When the print edition has an entire line or the end of the line of `...`, insert `…` three times (`………`).


---


**Obsolete**: 
`<pb>`. It is used at the beginning of a new page. It has the attribute `@n` for the value of property `roud-oeuvres:hasSeqnum`. For the XML/TEI export, we could add the attribute `@source` pointing to the ARK of the manuscript, because images in Sipi have no ARK; it would correspond to the value of the property `roud-oeuvres:pageIsPartOfManuscript`. And the attribute `@ana` for the value of the property `roud-oeuvres:pageHasName`.




