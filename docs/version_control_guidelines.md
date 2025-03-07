# Version Control Guidelines

**Objective:**
Establish a clear and consistent version control strategy to manage code changes effectively, facilitate collaboration, and ensure a stable and maintainable codebase.

## 1. Repository Structure
Organize the repository into the following directories:
```
s2517842/
├── src/                # Source code
├── docs/               # Documentation
├── tests/              # Test scripts
├── libraries/          # Dependencies
├── .gitignore          # Git ignore file
├── .DS_Store           # Store custom properties of directories
├── README.md           # Project description
└── LICENSE             # License file
```

## 2. Branching Strategy
- **Main Branch:** `main`
  - The main branch should always be stable and contain production-ready code.
- **Develop Branch:** `tools-tests`
  - Used for integrating the testing process for different interface tools.
- **Develop Branch:** `case-PythonInterface`
  - Used for integrating the final product python interface devlopment.

**Branch Naming Conventions:**
- Use descriptive names and include the issue number. 

## 3. Commit Messages
- **Format:** `<type>(<issue number>): <description>`
  - **Type:** dev, fix, docs, style, refactor, perf, test
  - **Issue Number:** mark the issue numbers if applicable
  - **Description:** Short summary of the changes.
- **Example:** `dev: add makefile to compile fortran code in f2py`

**Guidelines:**
- Write clear, concise, and descriptive commit messages.
- Use the imperative mood in the description (e.g., "add" not "added").
- Include issue numbers if applicable (e.g., `fix #123`).

## 4. Merging Strategy
- **Feature Branches:**
  - Create a pull request (PR) to merge feature branches into the `develop` branch.
  - Ensure all tests pass before merging.
- **Bugfix Branches:**
  - Create a PR to merge bugfix branches into the `develop` branch.
  - Ensure all tests pass and the fix is verified.

## 5. Code Reviews
- All PRs must be reviewed by author carefully. 
- Reviewers should check for:
  - Code quality and readability
  - Adherence to coding standards
  - Adequate testing
  - Potential bugs or issues

## 6. Workflow
1. **Create a Branch:**
   - `git checkout -b feature/feature-name`
2. **Make Changes:**
   - Make code changes and commit them following the commit message guidelines.
3. **Push Changes:**
   - `git push origin feature/feature-name`
4. **Create a Pull Request:**
   - Open a PR to merge the feature branch into `develop`.
5. **Review and Merge:**
   - Address any feedback from the code review.
   - Merge the PR once approved and tests pass.
6. **Delete Branch:**
   - Delete the feature branch after merging (both locally and remotely).

