// KEEP IN MIND THIS FILE IS IMPORTED ON EACH PAGE

// Re-Usable error function where "container" is the div meant to wrap all the errors.
function showError(container, message, detail = null) {
    container.innerHTML = `
        <div class="mb-2 py-2 px-4 text-sm text-red-800 bg-red-100 border border-red-300 rounded-md">
            <div class="flex justify-between items-center">
                <span>${message}</span>
                <button
                    type="button"
                    class="cursor-pointer font-bold ml-2 text-red-600 hover:text-red-900"
                    onclick="this.parentElement.parentElement.remove()">
                    &times;
                </button>
            </div>

            ${detail ? `
                <div class="mt-2 pt-2 border-t border-red-300 text-xs text-red-700">
                    ${detail}
                </div>
            ` : ''}
        </div>
    `;
}