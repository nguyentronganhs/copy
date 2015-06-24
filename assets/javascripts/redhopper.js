(function ($) {
	$(function () {
		var dragSrcEl;

		function handleDragStart(e) {
			this.style.opacity = '0.6';  // this / e.target is the source node.

			dragSrcEl = this;

			e.dataTransfer.effectAllowed = 'move';
			e.dataTransfer.setData('text/html', this.innerHTML);
		}

		function handleDragEnd(e) {
			this.style.opacity = '1';  // this / e.target is the source node.
		}

		function handleDragEnter(e) {
			this.classList.add('dragover');  // this / e.target is the target node.
		}

		function handleDragOver(e) {
			if (e.preventDefault) {
				e.preventDefault(); // Necessary. Allows us to drop.
			}
		}

		function handleDragLeave(e) {
			this.classList.remove('dragover');  // this / e.target is the target node.
		}

		function handleDrop(e) {
			// this/e.target is current target element.

			if (e.stopPropagation) {
				e.stopPropagation(); // Stops some browsers from redirecting.
			}

			// Don't do anything if dropping the same column we're dragging.
			if (dragSrcEl != this) {
				// Set the source column's HTML to the HTML of the column we dropped on.
				dragSrcEl.innerHTML = this.innerHTML;
				this.innerHTML = e.dataTransfer.getData('text/html');
				this.classList.remove('dragover');  // this / e.target is the target node.
			}

			return false;
		}

		var issues = document.querySelectorAll('ol.kanban [draggable]');
		[].forEach.call(issues, function(col) {
			col.addEventListener('dragstart', handleDragStart, false);
			col.addEventListener('dragend', handleDragEnd, false);
		});

		issues = document.querySelectorAll('ol.kanban [dropzone="move"]');
		[].forEach.call(issues, function(col) {
			col.addEventListener('dragenter', handleDragEnter, false)
			col.addEventListener('dragover', handleDragOver, false);
			col.addEventListener('dragleave', handleDragLeave, false);
			col.addEventListener('drop', handleDrop, false);
		});
	})
})(jQuery)
