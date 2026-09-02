// KEEP IN MIND THIS FILE IS IMPORTED ON EACH PAGE

// For `/components/ui/dropdown_button.cfm`
document.addEventListener("click", async function (event) {
    const button = event.target.closest("[data-action-url]");

    if (!button) {
        return;
    }

    const response = await fetch(button.dataset.actionUrl, {
        method: "POST"
    });

    // todo -- Logic for Error Handling when response has an error code.
});