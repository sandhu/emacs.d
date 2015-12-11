{:user
 {:jvm-opts ["-XX:-OmitStackTraceInFastThrow"]
  :plugins [[cider/cider-nrepl "0.10.0"]
            [refactor-nrepl "2.0.0-SNAPSHOT"]
            [lein-ancient "0.6.8"]]
  :dependencies [[org.clojure/tools.nrepl "0.2.12"]
                 [criterium "0.4.3"]]}}
