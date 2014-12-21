{:user
 {:plugins [;; REPL
            [cider/cider-nrepl "0.8.2"]
            [refactor-nrepl "0.2.2"]

            ;; Application server
            [lein-immutant "2.0.0-SNAPSHOT"]

            ;; Automated testing
            [lein-cloverage "1.0.2"]
            [lein-test-out "0.3.1"]

            ;; Package management
            [lein-ancient "0.5.5"]
            [lein-clojars "0.9.1"]

            ;; Documentation
            [codox "0.6.8"]
            [lein-clojuredocs "1.0.2"]

            ;; Static analysis
            [lein-typed "0.3.4"]
            ;; [jonase/eastwood "0.1.2"]
            [lein-bikeshed "0.1.6"]
            [lein-kibit "0.0.8"]]

  :dependencies [[org.clojars.gjahad/debug-repl "0.3.3"]
                 [difform "1.1.2"]

                 [spyscope "0.1.4"]
                 [org.clojure/tools.trace "0.7.8"]

                 [org.clojure/tools.namespace "0.2.4"]
                 [im.chit/vinyasa "0.2.0"]
                 [slamhound "1.5.5"]

                 [criterium "0.4.3"]]

  :injections [(require 'spyscope.core)
               (require 'alex-and-georges.debug-repl)
               (require 'com.georgejahad.difform)
               (require '[vinyasa.inject :as inj])
               (inj/inject 'clojure.core '>
                           '[[clojure.repl apropos dir doc find-doc pst source]
                             [clojure.tools.trace trace trace-forms trace-ns trace-vars
                              untrace-ns untrace-vars]
                             [clojure.test run-tests run-all-tests]
                             [clojure.pprint pprint pp]
                             [com.georgejahad.difform difform]
                             [alex-and-georges.debug-repl debug-repl]
                             [vinyasa.pull pull]])]}}
