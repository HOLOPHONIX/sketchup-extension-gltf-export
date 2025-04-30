# Contributing to the HOLOPHONIX glTF Exporter

We welcome contributions from the community! Whether you’re fixing a bug, adding a feature, or improving documentation, your help is appreciated. Here’s how you can get started.

---

## Prerequisites

- **Ruby**: Ensure you have a standalone Ruby installation. See the Ruby installation guide for details.
- **Bundler**: Install the Bundler gem to manage dependencies:

    ```bash
    gem install bundler
    ```

---

## Setup

1. **Fork the Repository**: Click the "Fork" button on the GitHub repository page to create your own copy.
2. **Clone the Repository**:

     ```bash
     git clone https://github.com/YOUR_USERNAME/sketchup-extension-vscode-project.git
     cd sketchup-extension-vscode-project
     ```

3. **Install Dependencies**:

     ```bash
     bundle install
     ```

---

## Making Changes

1. **Create a New Branch**:

     ```bash
     git checkout -b feature/your-feature-name
     ```

     Use a descriptive branch name that reflects the changes you’re making.

2. **Make Your Changes**:
     - Write your code or update the documentation.
     - Follow the project’s coding standards and style guidelines.

3. **Test Your Changes**:
     - Run RuboCop to ensure your code adheres to the style guide:

         ```bash
         bundle exec rubocop
         ```

     - Test the extension in SketchUp to verify functionality.

4. **Commit Your Changes**:

     ```bash
     git add .
     git commit -m "Your detailed commit message"
     ```

     Write clear and concise commit messages that explain the purpose of your changes.

5. **Push Your Changes**:

     ```bash
     git push origin feature/your-feature-name
     ```

---

## Submitting a Pull Request

1. **Open a Pull Request**:
     - Go to the GitHub repository page and click "New Pull Request."
     - Select your branch and provide a detailed description of your changes.

2. **Review Process**:
     - Your pull request will be reviewed by the maintainers.
     - Be prepared to address feedback or make additional changes.

---

## Code Style and Guidelines

- **RuboCop**: Follow the RuboCop style guide. Run `bundle exec rubocop` to check your code.
- **Testing**: Ensure your changes are thoroughly tested before submitting a pull request.

---

## Reporting Issues

If you encounter a bug or have a feature request, please open an issue on GitHub. Include the following details:

- A clear description of the problem or request.
- Steps to reproduce the issue (if applicable).
- Screenshots or error messages (if applicable).

---

## Acknowledgments

Thank you for contributing to the HOLOPHONIX glTF Exporter! Your efforts help make this tool better for everyone.
