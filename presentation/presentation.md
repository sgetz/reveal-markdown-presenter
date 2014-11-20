# Less

---

#Intro

---

#Basic Additions

----

##Variables

----

###Benefits of Variables

- Prevent Repetition - DRY
- Enhances Maintainability 
- Facilitates Easy Customization

----

###Variable Declaration

```less
    @var: red;
```

- prefix with `@` follow by name like: `@var`
- name can contain any alphanumeric, `_`, or `-`
- `:` used to assign value
- value can be any valid css *with a few additions*
- `;` terminate declaration

----

###Variable Usage

- in place of values - `.some-class {background-color: @highlight-color}`
- as part of selector using `@{var}` interpolation syntax
- as part of property using `@{var}` interpolation syntax

<!--codeExampleSideBySide: varible-usage.less|varible-usage.css-->

###Variable Usage -- @@var Interpolation

<!--codeExampleSideBySide: varible-double-at-interpolation.less.less|varible-double-at-interpolation.less.css-->

- Variable can be set to the name of another variable
- `@@` used to evaluate the variable name
- Note: only works for value not for selector or property name



----

###Variable Scope - Lazy Loading

- Variable are **lazy loaded** & can be defined after use

<!--codeExampleSideBySide: varible-scope-lazy-loaded.less|varible-scope-lazy-loaded.css -->

----

###Varible Scope - Redeclaration 

- The last definition of a variable will win

<!--codeExampleSideBySide: varible-scope-redecloration.less|varible-scope-redecloration.css-->

- This make for easy customization

```less
@import "bootstrap/less/bootstrap.less";
@link-hover-color: #ff0000; // red
```

----

###Varible Scope - As References

- Variables can be assigned the value of other variables
- Last definition wins still applys

<!--codeExampleSideBySide: varible-scope-as-references.less|varible-scope-as-references.css-->

----

###Varible Scope - And Nesting

<!--codeExampleSideBySide: varible-scope-and-nesting.less|varible-scope-and-nesting.css-->

----

##Parametric Mixins

----

###Parametric Mixins

<!--codeExample: sample-param-mixin.less-->

- differ from class mixins in that they
  - name is always followed by `()`
  - must be invoked
  - can take arguments
  - wont generate css until used
  - unique scoping rules

----

###Parametric Mixins

<!--codeExampleSideBySide: param-mixin-plain.less|param-mixin-plain.css-->

----

###Parametric Mixins

<!--codeExampleSideBySide: param-mixin-plain-plus-eval.less|param-mixin-plain-plus-eval.css-->

----

###Parametric Mixins - Arguments

- always start with `@`
- delimited by either `,` or `;`
- set default values with `:`  eg `@arg:default`

----

###Parametric Mixins - Arguments

<!--codeExampleSideBySide: para-mixin-at-args.less|para-mixin-at-args-->

- `@arguments` contains all the arguments
- `@rest...` to take remaining args

----

###Parametric Mixins - Variable Scope

<!--codeExampleSideBySide: para-mixins-var-scope-one.less|para-mixins-var-scope-one.css-->

- Expose local variables to callers scope

----

###Parametric Mixins - Variable Scope

<!--codeExampleSideBySide: para-mixins-var-scope-two.less|para-mixins-var-scope-two.css-->

- However variable defined directly in callers scope can not be overriden

----


###Parametric Mixins - Guards

<!--codeExample: para-mixins-gards-one.less-->

- allow for conditional mixins

<div class="demo">
  <p><span class="pmg-demo-one">.mixin(pink)</span> -&gt; <span class="pmg-demo-one-changed">#ff4162</span></p>
  <p><span class="pmg-demo-two">.mixin(brown)</span> -&gt; <span class="pmg-demo-two-changed">#3f1010</span></p>
</div>

----

###Parametric Mixins - Guards

<!--codeExampleSideBySide: param-mixins-guard-conds.less|param-mixins-guard-conds.css-->

- `>`, `>=`, `=`, `=<`, `<`
- `,` simulates `or`, `and` keyword combines guards
- `not` keyword negates
- sets default mixin with: `when (default())`

----

####Parametric Mixins - Loops

<!--codeExample: paramitized-mixins-loops-header-alone.less-->

----

###Parametric Mixins - Loops

<!--codeExampleSideBySide: paramitized-mixins-loops-header.less|paramitized-mixins-loops-header.css-->

----

###Parametric Mixins - Loops

<!--codeExample: paramitized-mixins-loops-header-color.less-->

----

###Parametric Mixins - Loops

<div class="demo header-loop">
  <h1>h1</h1>
  <h2>h2</h2>
  <h3>h3</h3>
  <h4>h4</h4>
  <h5>h5</h5>
  <h6>h6</h6>
</div>

----

##Parametric Mixins - Passing Rulesets & Rulesets Vars

----

###Parametric Mixins - Rulesets Vars

- New to Less v1.7.0 


---

#Progamatic Additons

---

#Other/Missilanious Featchure/Additonss

---

#Tips And Tools

