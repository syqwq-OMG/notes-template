#import "template.typ": *
#show: note.with(course: "线性代数", watermark: str(math.copyright) + "syqwq")

= 向量空间

Suppose $V$ is a linear space on $FF$.

线性代数是研究有限维向量空间上的线性映射的学问.我们最终会理解这些术语的具体 含义.在本章中，我们将定义向量空间并讨论它们的基本性质.

在线性代数中，如果将复数与实数放在一起研究，就会得到更好的定理和更深刻的见解. 因此，我们将从介绍复数及其基本性质开始.
我们将把平面和三维空间这些例子推广到 $RR^(n)$  和 $CC^(n)$ ，再进一步推广得到向量空间的概念. 我们将会明白，向量空间是具有满足自然的代数性质的加法和标量乘法运算的集合.

接着，我们将讨论子空间.子空间之于向量空间，就类似子集之于集合.最后，我们将关注子空间的和(类似于子集的并集)与子空间的直和(类似于不相交集合的并集)

== $RR^(n)$ 和 $CC^(n)$

你应该已经熟悉了实数集合 $RR$  的基本性质.发明复数，是为了让我们可以取负数的平方 根.我们的想法是，假设 $-1$  有平方根，将其用 $i$  表示，并且它遵守通常的算术规则. 正式的定义如下.

#definition([复数(complex number) $CC$])[
  - 一个复数是一个有序对 $(a,b)$，其中 $a,b in RR$，不过我们会把这个写成 $a+b i$
  - 全体复数集合用 $CC$ 表示：
  $
    CC=\{ a+b i: a,b in RR \}
  $
  - $CC$ 上的加法和乘法定义为
  $
    (a+b i)+(c+d i)=(a+c)+(b+d)i \
    (a+b i)(c+d i)=(a c-b d )+(a d + b c)i
  $
  其中 $a,b,c,d in RR$.
]

#problem[
  证明： $sqrt(2) in.not QQ$.
]

=== 你好啊
111111

#definition([复数(complex number) $CC$])[
  - 一个复数是一个有序对 $(a,b)$，其中 $a,b in RR$，不过我们会把这个写成 $a+b i$
  - 全体复数集合用 $CC$ 表示：
  $
    CC=\{ a+b i: a,b in RR \}
  $
  - $CC$ 上的加法和乘法定义为
  $
    (a+b i)+(c+d i)=(a+c)+(b+d)i \
    (a+b i)(c+d i)=(a c-b d )+(a d + b c)i
  $
  其中 $a,b,c,d in RR$.
]

#problem[
  证明： $sqrt(2) in.not QQ$.
]
#theorem([length of $z$ ])[
  Suppose $z in CC$, then we have:
  $
    z overline(z) = overline(z)z=abs(z)^(2)
  $
]

如果 𝑎 ∈ R，那么我们将 𝑎 + 0i 等同于实数 𝑎.由此，我们将 R 视为 C 的子集.我们通常
将 0 + 𝑏i 简写作 𝑏i，将 0 + 1i 简写作 i. 上述复数乘法定义式的来由可以这样说

#example([复数的算数运算])[
  运用 1 中的性质，可以算出 $(2+3i)(4+5i)$ 的值：
  $
    (2+3i)(4+5i) & =2 dot (4+5i)+(3i) dot (4+5i) \
                 & =-7+22i
  $
]
== 向量空间的定义

#definition([复数(complex number) $CC$])[
  - 一个复数是一个有序对 $(a,b)$，其中 $a,b in RR$，不过我们会把这个写成 $a+b i$
  - 全体复数集合用 $CC$ 表示：
  $
    CC=\{ a+b i: a,b in RR \}
  $
]
== 向量空间的定义

#pagebreak()

= Vector space with measurement

Back in middle school, we know such mapping called 'inner product', who receives 2 vectors and gives out one value. With innner product, we can define the length of a vector, angles of 2 vectors, and so on ... and that's the motivation of this chapter.
== Bilinear function
From the concept of inner product, we could formalize a kind of function $f: V times V -> FF$ , and it's also a linear stuff.

#definition("Bilinear function")[
  For $f: V times V -> FF$, if it satisfies linearity for both of the 2 variables, aka.
  - $f(k alpha_1+alpha_2, beta)=k f(alpha_1,beta)+f(alpha_2,beta)$
  - $f(alpha , k beta_1+beta_2)=k f(alpha,beta_1)+f(alpha+beta_2)$
  then we call such $f$ a *bilinear function* on $V$.
]

#theorem("Expansion of bilinear function")[
  Let $V = "span" (e_1,e_2, dots.h.c ,e_n )$, and 2 vectors in $V$ are $alpha = (a_1,a_2, dots.h.c ,a_n)' , beta = (b_1,b_2, dots.h.c ,b_n)'$, we have

  $
    f(alpha,beta)=sum_(i=1)^(n) sum_(j=1)^(n) a_i b_j dot f(e_i,e_j)
  $
]
#proof[
  Use the linearity to expand $f$, first $alpha$, then $beta$. Readers can verify themselves.
]

#theorem("Matrix represention of bilinear function")[
  Let $V="span"( e_1,e_2, dots.h.c ,e_n ),
  alpha = [e_1 space e_2 space dots.h.c space e_n] x,
  beta = [e_1 space e_2 space dots.h.c space e_n] y$, consider a matrix
  $
    A=mat(
      f(e_1,e_1), f(e_1,e_2), dots.h.c, f(e_1,e_n);
      f(e_2,e_1), f(e_2,e_2), dots.h.c, f(e_2,e_n);
      dots.v, dots.v, dots.down, dots.v;
      f(e_n,e_1), f(e_n,e_2), dots.h.c, f(e_n,e_n)
    )
  $
  we conclude: $f(alpha, beta)=x' A y$.
]
#proof[
  Use definiton of matrix multiplication, readers can verify themselves.
]

We call matrix $A$ a *measure matrix*. You may be confused with this naming, but later we'll explain.

However, for this matrix $A$ we can interpret it from another perspective.

#theorem("Another interpretation of measure matrix")[
  Let $V="span"\{ e_1,e_2, dots.h.c ,e_n \}$, its dual space with dual basis $V'="span"\{ f_1,f_2, dots.h.c ,f_n \}$ and $f$ is a bilinear function on $V$. Consider a mapping $phi: V -> V'$, where $phi(beta)=f(x, beta)$, we have
  $
    phi [e_1 space e_2 space dots.h.c space e_n]=
    [f_1 space f_2 space dots.h.c space f_n]A
  $
  which means $A$ is the matrix of $phi$ under a basis of $V$ and its correspondent dual basis.
]
#proof[
  This is proof.
]

#problem("Basis")[
  List a basis for the following linear spaces with default addition and scaling operator:
  - $RR^(2) $
  - $CC$  
]
#solution[
  - $(1,0)'$, $(0,1)'$  
  - $1$ 
]

```cpp
#include <iostream>
using namespace std;

int main(){
  cout<<111<<endl;
  return 0;
}
```

