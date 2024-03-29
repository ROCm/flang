.. Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
.. See https://llvm.org/LICENSE.txt for license information.
.. SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception

.. title:: Welcome to Flang's documentation!

.. toctree::
   :maxdepth: 2

   ReleaseNotes

..
  Using Flang
  ===========

..
    toctree::

..    * `User's Manual <http://flang.org/docs/html/manual.html>`_
..    * `FAQ <http://flang.org/docs/html/faq.html>`_

Flang Design Documents
======================

Common
------

..
    Intro to be written

.. toctree::
   :maxdepth: 1

   flang2/coding
   Target Machine <flang1/machar>
   flang2/error
   flang1/dinit
   flang2/fin

Front-end Design
----------------

.. toctree::
   :maxdepth: 1

   flang1/intro
   flang1/controller
   flang1/scanner
   flang1/parser
   flang1/semant
   flang1/transform
   flang1/outconv
   flang1/output
   flang1/errmsg

Front-end Internals
-------------------

.. toctree::
   :maxdepth: 1

   Grammar <flang1/grammar>
   flang1/ast
   flang1/symtab
   Intrinsics & Generics <flang1/symini>

Back-end Design
---------------

.. toctree::
   :maxdepth: 1

   Introduction <flang2/intro>
   Program Controller <flang2/controller>
   Expander <flang2/expander>
   ILM Description <flang2/ilm>
   ILI Description <flang2/ili>
.. LLVM Bridge to be written

Back-end Internals
------------------

.. toctree::
   :maxdepth: 1

   flang2/symtab
   ILM Definitions <flang2/ilmtp>
   ILI Definitions <flang2/ilitp>
   Intrinsics & Generics <flang2/symini>
   flang2/errmsg

Source code
-----------

.. * `Doxygen generated documentation <http://flang.org/docs/doxygen/html/index.html>`_

Indices and tables
==================

* :ref:`genindex`
* :ref:`search`
