(setq-default powerline-gahag-light-format
              '("%e"
                (:eval
                 (let* ((active (powerline-selected-window-active))
                        (mode-line-buffer-id (if active 'mode-line-buffer-id 'mode-line-buffer-id-inactive))
                        (mode-line (if active 'mode-line 'mode-line-inactive))
                        (face0 (if active 'powerline-active0 'powerline-inactive0))
                        (face1 (if active 'powerline-active1 'powerline-inactive1))
                        (face2 (if active 'powerline-active2 'powerline-inactive2))
                        (lhs (list (powerline-raw "%*" face0 'l)
                                   (powerline-buffer-id `(mode-line-buffer-id ,face0) 'l)
                                   (powerline-raw " " face0)
                                   (powerline-vc face1)))
                        (rhs (list (powerline-raw global-mode-string face1 'r)
                                   (powerline-raw " " face0)
                                   (powerline-raw "%l" face0 'r)
                                   (powerline-raw "%c" face0 'r)
                                   (powerline-fill face0 0)
                                   ))
                        (center (list (powerline-raw " " face1)
                                      (when (and (boundp 'erc-track-minor-mode) erc-track-minor-mode)
                                        (powerline-raw erc-modified-channels-object face2 'l))
                                      (powerline-major-mode face2 'l)
                                      (powerline-process face2)
                                      (powerline-raw " :" face2)
                                      (powerline-minor-modes face2 'l)
                                      (powerline-raw " " face2))))
                   (concat (powerline-render lhs)
                           (powerline-fill-center face1 (/ (powerline-width center) 2.0))
                           (powerline-render center)
                           (powerline-fill face1 (powerline-width rhs))
                           (powerline-render rhs))))))
