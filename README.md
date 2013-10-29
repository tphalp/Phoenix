## Phoenix

The weird window manager for OS X

#### Rationale

My goal is to be able to write configs like this:

```clojure
(def mash ["cmd" "alt" "ctrl"])
(def mash-shift ["cmd" "alt" "shift"])

(def *window-grid-width* 4)

(def *margin-x* 5)
(def *margin-y* 5)

(update-settings {:alert-should-animate false
                  :alert-default-delay 0.5})

(defmacro defbinding [key mods & body]
  `(bind ~key ~mods
         (fn []
           ~@body)))

(defbinding "D" mash #(shell "open -a Dictionary"))

(defn snap-to-grid [win]
  (if (normal-window? win)
    (set-grid win nil)))

(defn maximize-with-margins [win]
  (let [f (-> win screen frame-without-dock-or-menu)]
    (set-frame win (inset f *margin-x* *margin-y*))))

(defn change-grid-width [by]
  (def *window-grid-width* (max 1 (+ by *window-grid-width*)))
  (alert (format "grid is now %d tiles wide" *window-grid-width*))
  (doseq [win get-visible-windows]
    (snap-to-grid win)))

(defbinding ";" mash #(snap-to-grid (get-focused-window)))
(defbinding "'" mash #(doall (map snap-to-grid (get-visible-windows))))

(defbinding "=" mash #(change-grid-width +1))
(defbinding "-" mash #(change-grid-width -1))

(defbinding "H" mash_shift #(-> (get-focused-window) (focus-window-left)))
(defbinding "L" mash_shift #(-> (get-focused-window) (focus-window-right)))
(defbinding "K" mash_shift #(-> (get-focused-window) (focus-window-up)))
(defbinding "J" mash_shift #(-> (get-focused-window) (focus-window-down)))




(defbinding "N" mash
  (let [win (get-focused-window)]
    (set-grid win
              (get-grid win)
              (-> win
                  (get-screen)
                  (get-next-screen)))))

(defbinding "P" mash
  (let [win (get-focused-window)]
    (set-grid win
              (get-grid win)
              (-> win
                  (get-screen)
                  (get-previous-screen)))))

(defbinding "M" mash
  (-> (get-focused-window)
      (maximize-with-margins)))

(defbinding "H" mash
  (let [win (get-focused-window)
        r (get-grid win)
        r (assoc :x (max 0 (- (:x r) 1)))]
    (set-grid win r)))

(defbinding "L" mash
  (let [win (get-focused-window)
        r (get-grid win)
        r (assoc :x (min (- *window-grid-width* (:w r))
                         (+ (:x r) 1)))]
    (set-grid win r)))

(defbinding "O" mash
  (let [win (get-focused-window)
        r (get-grid win)
        r (assoc :w (min (- *window-grid-width* (:x r))
                         (+ (:w r) 1)))]
    (set-grid win r)))

(defbinding "I" mash
  (let [win (get-focused-window)
        r (get-grid win)
        r (assoc :w (max 1
                         (- (:w r) 1)))]
    (set-grid win r)))

(defbinding "J" mash
  (let [win (get-focused-window)
        r (get-grid win)
        r (assoc r :h 1 :y 1)]
    (set-grid win r)))

(defbinding "K" mash
  (let [win (get-focused-window)
        r (get-grid win)
        r (assoc r :h 1 :y 0)]
    (set-grid win r)))

(defbinding "U" mash
  (let [win (get-focused-window)
        r (get-grid win)
        r (assoc r :h 2 :y 0)]
    (set-grid win r)))
```
