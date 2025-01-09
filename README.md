# 📜 CV

📜 `CV` is an 🪄 [`awesome-bash-cli`](https://github.com/kamangir/awesome-bash-cli) (`abcli`) plugin for [my](https://abadpour.com/) CV, in two versions: [compact](https://abadpour-com.s3.ca-central-1.amazonaws.com/cv/arash-abadpour-resume.pdf) and [full](https://abadpour-com.s3.ca-central-1.amazonaws.com/cv/arash-abadpour-resume-full.pdf).

```bash
pip install abadpour
```

```mermaid
graph LR
    build["CV<br>build<br>~publish"]
    clean["CV<br>clean"]
    CV["pdf"]:::folder

    build --> CV
    clean --> CV

    classDef folder fill:#999,stroke:#333,stroke-width:2px;
```

---

[![PyPI version](https://img.shields.io/pypi/v/abadpour.svg)](https://pypi.org/project/abadpour/)
