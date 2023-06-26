### lcov
2023年6月26日
---
```
lcov -c -i -d . -o init.info

./a.out
lcov -c -d . -o cover.info

lcov -a init.info -a cover.info -o total.info

genhtml -o result total.info
```
