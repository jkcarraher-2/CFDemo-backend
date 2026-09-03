// KEEP IN MIND THIS FILE IS IMPORTED ON EACH PAGE

// Re-Usable error function where "container" is the div meant to wrap all the errors.
function showError(container, message) {
    container.innerHTML = `
        <div class="mb-2 py-2 px-4 text-sm text-red-800 bg-red-100 border border-red-300 rounded-md flex justify-between items-center">
            <span>
                ${message}
            </span>
            <button
                type="button"
                class="cursor-pointer font-bold ml-2 text-red-600 hover:text-red-900"
                onclick="this.parentElement.remove()">
                &times;
            </button>
        </div>
    `;
}