# 📜 CV

📜 `CV` is an [`abcli`](https://github.com/kamangir/awesome-bash-cli) plugin for my CV, in two versions: [compact](./arash-abadpour-resume.pdf) and [full](./arash-abadpour-resume-full.pdf).

```bash
pip install abadpour
```

```mermaid
graph LR
    build["CV<br>build<br>push"]
    clean["CV<br>clean"]
    CV["pdf"]:::folder

    build --> CV
    clean --> CV

    classDef folder fill:#999,stroke:#333,stroke-width:2px;
```

---

[![PyPI version](https://img.shields.io/pypi/v/abadpour.svg)](https://pypi.org/project/abadpour/)
