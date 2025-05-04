# 🚀 What is Static Type Checking?

Static type checking refers to the process of verifying the types of variables, function arguments, return types, and so on **without executing the program**. This is done by tools like **mypy**.

For example, when you add type hints (e.g., `int`, `str`, `float`) in your code, static type checkers analyze your code to ensure that you're using the correct types as specified. It helps catch errors early during development, without having to run the program.

In Python, type checking is **not mandatory**, but it’s useful when you want to catch potential errors before runtime.

## How Does Static Type Checking Work?

Tools like **mypy** analyze your Python code and check the type correctness of the variables and function signatures that you specify using type hints.

Consider this simple example:

```python
def add(a: int, b: int) -> int:
    return a + b
```

A static type checker like mypy will verify that `a` and `b` are both integers and that the function returns an integer. If you mistakenly pass a non-integer, such as a string, mypy will raise a type error.

### Runtime vs. Static Type Checking

- **Runtime** refers to the execution of your program. At runtime, Python will **not enforce any type constraints***. You can assign any value to any variable during the program’s execution.

- **Static type** checking is done **before** the program runs. It helps you catch errors early, but it doesn't affect the program's execution. If a type error is found, it will be raised before you even run the code.

### Python and Static Type Checking: A Special Case

Python is a dynamically typed language, meaning you don’t have to explicitly define the types of variables or function parameters. However, with type hints and tools like **mypy**, you can introduce **optional static type checking**.

For example:

``` python
from typing import Final

PI: Final = 3.1415
```

Here,`Final` is a way of signaling that the value of `PI` should not be changed. **mypy** can then warn you if you try to reassign `PI`, but it won't stop you at runtime because Python doesn’t enforce immutability natively.

### What is `mypy`?

**mypy** is a tool that checks for type consistency in your code based on the type hints you've provided. It analyzes your code without running it, which means it provides feedback **before** your program executes.

- When you run `mypy filename.py` in the terminal, it checks your file for type correctness and potential errors, like using an integer where a string is expected.

- It does **not** run the program; instead, it scans the code statically.

### Why Is Static Type Checking Important?

Static type checking helps you catch type-related bugs early. While Python is flexible at runtime, having clear type information can make your codebase easier to maintain and understand.

### What Happens When You Install mypy?

The `typing` module is part of Python’s standard library, meaning it's available by default, and you don’t need to install anything extra to use it. However, `mypy` is an **external tool** that you install separately (using `pip install mypy`) to perform static type checking.

- Without `mypy`: If you only use type hints (like `x: int`) in your code, Python won’t enforce them during runtime. You’ll get no warnings or errors if you break your type rules. The type hints are **informational** only.

- With `mypy`: When you install and run `mypy`, it reads your code and checks if the types you’ve specified are being followed correctly. `mypy` **will raise warnings or errors if it finds any discrepancies** between your declared types and how they are used in your code.
