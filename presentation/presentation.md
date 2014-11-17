# Less

---

#Intro

---

#Basic Additons

----

##Varibles

----

###Benifits of Varibles

- prevent repition of common values - DRY
- enhances maintaiblity
- facilitates easy customization

----

###Varible Declaration

```less
    @var: red;
```

- prefix with `@` follow by name like: `@var`
- name can contain any
    - alphanumeric character
    - underscore `_`
    - dash `-`
- `:` used to assign value
- value can be any valid css *with a few additons*
- `;` terminate decloration

----

###Varible Usage

<!--codeExample: varible-usage.less-->

- inplace of values - `.some-class {background-color: @highlight-color}`
- as part of selector using `@{var}` interpolation syntax
- as part of property using `@{var}` interpolation syntax



---

#Progamatic Additons

---

#Other/Missilanious Featchure/Additonss

---

#Tips And Tools

