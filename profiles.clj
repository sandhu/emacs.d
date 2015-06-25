{:user
 {:jvm-opts ["-XX:-OmitStackTraceInFastThrow"]
  :plugins [;; REPL
            [cider/cider-nrepl "0.9.1"]
            [refactor-nrepl "1.0.5"]

            ;; Application server
            [lein-immutant "2.0.0"]

            ;; Automated testing
            [lein-cloverage "1.0.2"]
            [lein-test-out "0.3.1"]

            ;; Package management
            [lein-ancient "0.6.7"]
            [lein-licenses "0.2.0"]
            [lein-clojars "0.9.1"]

            ;; Documentation
            [codox "0.8.11"]
            [lein-clojuredocs "1.0.2"]

            ;; Static analysis
            [lein-typed "0.3.5"]
            ;; [jonase/eastwood "0.1.2"]
            [lein-bikeshed "0.2.0"]
            [lein-kibit "0.1.2"]]

  :dependencies [[org.clojure/tools.nrepl "0.2.10"]
                 [org.clojars.gjahad/debug-repl "0.3.3"]
                 [difform "1.1.2"]

                 [spyscope "0.1.5"]
                 [org.clojure/tools.trace "0.7.8"]
                 [org.clojure/tools.namespace "0.2.10"]
                 [alembic "0.3.2"]
                 [im.chit/vinyasa.inject "0.3.4"]
                 [im.chit/vinyasa.reflection "0.3.4"]
                 [io.aviso/pretty "0.1.17"]

                 [slamhound "1.5.5"]
                 [criterium "0.4.3"]]

  :injections [(require 'spyscope.core)
               (require '[vinyasa.inject :as inject])
               (inject/in [vinyasa.inject :refer [inject [in inject-in]]]
                          [clojure.pprint pprint]
                          [clojure.java.shell sh]
                          [alembic.still [distill pull] lein [load-project pull-project]]
                          [clojure.tools.namespace.repl refresh]
                          [clojure.repl doc source]

                          clojure.core
                          [vinyasa.reflection .& .> .? .* .% .%>])]}}
