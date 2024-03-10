/* The point of this script is to stop ThePrimeagen from hightlighting how he 
* wants. His twitter is here: https://twitter.com/ThePrimeagen
*/

// doesnt work across element tags.
// TODO: get it to only take effect for text in blog-content and work acorss nodes
let antiThePrimeagenEnabled = false;

function mouseSelection(element) {
    const selection = window.getSelection();
    if (!selection.isCollapsed) {
        const wordRange = document.createRange();

        let startNode = selection.anchorNode, startOffset = selection.anchorOffset;
        let endNode = selection.focusNode, endOffset = selection.focusOffset;

        if (selection.anchorNode === selection.focusNode) {
            if (selection.anchorOffset > selection.focusOffset) {
                [startOffset, endOffset] = [endOffset, startOffset];
            }
        } else if (selection.anchorNode.compareDocumentPosition(selection.focusNode) & Node.DOCUMENT_POSITION_FOLLOWING) {
            [startNode, endNode] = [endNode, startNode];
            [startOffset, endOffset] = [endOffset, startOffset];
        }

        let textContent = startNode.textContent;
        while (startOffset > 0 && /\S/.test(textContent[startOffset - 1])) {
            startOffset--;
        }

        textContent = endNode.textContent;
        while (endOffset < textContent.length && /\S/.test(textContent[endOffset])) {
            endOffset++;
        }

        wordRange.setStart(startNode, startOffset);
        wordRange.setEnd(endNode, endOffset);

        selection.removeAllRanges();
        selection.addRange(wordRange);
    }
}

document.addEventListener('htmx:load', function(evt) {
    let els = document.getElementsByClassName('blog-content');

    [...els].forEach((element, index, array) => {
        if (antiThePrimeagenEnabled) {
            element.addEventListener('mouseup', function(e) {
                mouseSelection(element);
                console.log("antiThePrimeagen: activated.");
            });
        }
    });
});
