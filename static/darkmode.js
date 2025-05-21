// Dark mode functionality
document.addEventListener('DOMContentLoaded', function() {
    // Create toggle button
    const toggleButton = document.createElement('button');
    toggleButton.className = 'dark-mode-toggle';
    toggleButton.setAttribute('aria-label', 'Toggle Dark Mode');
    toggleButton.innerHTML = '<i class="fa fa-moon-o"></i>';
    document.body.appendChild(toggleButton);

    // Check for saved theme preference or respect OS preference
    const prefersDarkMode = window.matchMedia('(prefers-color-scheme: dark)').matches;
    const savedTheme = localStorage.getItem('theme');
    
    // Apply theme based on saved preference or OS preference
    if (savedTheme === 'dark' || (savedTheme === null && prefersDarkMode)) {
        document.body.classList.add('dark-mode');
        toggleButton.innerHTML = '<i class="fa fa-sun-o"></i>';
    } else {
        document.body.classList.remove('dark-mode');
        toggleButton.innerHTML = '<i class="fa fa-moon-o"></i>';
    }

    // Toggle dark mode when button is clicked
    toggleButton.addEventListener('click', function() {
        document.body.classList.toggle('dark-mode');
        
        if (document.body.classList.contains('dark-mode')) {
            localStorage.setItem('theme', 'dark');
            toggleButton.innerHTML = '<i class="fa fa-sun-o"></i>';
        } else {
            localStorage.setItem('theme', 'light');
            toggleButton.innerHTML = '<i class="fa fa-moon-o"></i>';
        }
    });

    // Listen for OS theme changes
    window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', e => {
        if (localStorage.getItem('theme') === null) {
            if (e.matches) {
                document.body.classList.add('dark-mode');
                toggleButton.innerHTML = '<i class="fa fa-sun-o"></i>';
            } else {
                document.body.classList.remove('dark-mode');
                toggleButton.innerHTML = '<i class="fa fa-moon-o"></i>';
            }
        }
    });
});