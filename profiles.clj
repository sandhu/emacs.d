{:user
 {:jvm-opts ["-XX:-OmitStackTraceInFastThrow"]
  :plugins [[cider/cider-nrepl "0.10.0-SNAPSHOT"]
            [refactor-nrepl "2.0.0-SNAPSHOT"]

            [lein-ancient "0.6.7"]]

  :dependencies [[acyclic/squiggly-clojure "0.1.3-SNAPSHOT"]
                 ^:replace [org.clojure/tools.nrepl "0.2.10"]
                 [criterium "0.4.3"]]}}
