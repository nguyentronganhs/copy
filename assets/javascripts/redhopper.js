(function ($) {
	$(function () {
		var dragSrcEl;
		var dragSrcList;
		var dropzones;
		var dropzoneHeight;

		function handleDragStart(e) {
			this.style.opacity = '0.6';  // this / e.target is the source node.

			dragSrcEl = this;
			dragSrcList = $(this).parents('ol').first();
			dropzones = $(dragSrcList).children('hr');

			dropzones.attr('dropzone', 'move');
			[].forEach.call(dropzones, function(col) {
				col.addEventListener('dragenter', handleDragEnter, false)
				col.addEventListener('dragover', handleDragOver, false);
				col.addEventListener('dragleave', handleDragLeave, false);
				col.addEventListener('drop', handleDrop, false);
			});

			e.dataTransfer.effectAllowed = 'move';
			e.dataTransfer.setData('text/html', this.innerHTML);
		}

		function handleDragEnd(e) {
			this.style.opacity = '1';  // this / e.target is the source node.

			dropzones.attr('dropzone', '');
			[].forEach.call(dropzones, function(col) {
				col.removeEventListener('dragenter', handleDragEnter, false)
				col.removeEventListener('dragover', handleDragOver, false);
				col.removeEventListener('dragleave', handleDragLeave, false);
				col.removeEventListener('drop', handleDrop, false);
			});
		}

		function handleDragEnter(e) {
			dropzoneHeight = $(this).height();
			$(this).height($(dragSrcEl).height());

			this.classList.add('dragover');  // this / e.target is the target node.
		}

		function handleDragOver(e) {
			if (e.preventDefault) {
				e.preventDefault(); // Necessary. Allows us to drop.
			}
		}

		function handleDragLeave(e) {
			this.classList.remove('dragover');  // this / e.target is the target node.

			$(this).height(dropzoneHeight);
		}

		function handleDrop(e) {
			// this/e.target is current target element.
			this.classList.remove('dragover');  // this / e.target is the target node.

			if (e.stopPropagation) {
				e.stopPropagation(); // Stops some browsers from redirecting.
			}

			var issueToMove = $(dragSrcEl).attr('id').split('-')[1]
			var targetComponents = $(this).attr('id').split('-')
			var targetIssue = targetComponents[1]
			var movePosition = targetComponents[2]
			// Don't do anything if dropping the same column we're dragging.
			if (issueToMove !== targetIssue) {
				$.post('/redhopper_issues/move', {
					issue_id: issueToMove,
					target_issue_id: targetIssue,
					insert: movePosition
				}, function () {
					window.location.href = window.location.href;
				})
			}

			return false;
		}

		var issues = document.querySelectorAll('ol.kanban [draggable]');
		[].forEach.call(issues, function(col) {
			col.addEventListener('dragstart', handleDragStart, false);
			col.addEventListener('dragend', handleDragEnd, false);
		});
	})
})(jQuery)
