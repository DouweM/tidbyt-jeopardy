load("render.star", "render")
load("animation.star", "animation")
load("pixlib/const.star", "const")
load("pixlib/font.star", "font")
load("pixlib/file.star", "file")

def main(config):
  result = file.exec("run.py")

  category = result["category"]
  clue = result["clue"]
  answer = result["answer"]

  title_font = "CG-pixel-3x5-mono"
  title_height = font.height(title_font)
  clue_height = const.HEIGHT - title_height - 3

  background_color = "#0000AF"

  fps = const.FPS // 3
  delay = 1000 // fps

  return render.Root(
    delay=delay,
    show_full_animation=True,
    child=render.Box(
      color=background_color,
      child=render.Column(
        expanded=True,
        children=[
          render.Box(
            height=title_height,
            child=render.Text(category, font=title_font)
          ),
          render.Padding(
            pad=(0,1,0,1),
            child=render.Box(width=const.WIDTH, height=1, color="#FFFFFF")
          ),
          render.Stack(
            children=[
              render.Box(
                height=clue_height,
                width=const.WIDTH,
                child=render.WrappedText(
                  answer,
                  align="center",
                  font="tom-thumb"
                )
              ),
              animation.Transformation(
                duration=fps, # A second
                delay=fps * 10, # 10 seconds
                keyframes=[
                  animation.Keyframe(
                    percentage=1.0,
                    transforms=[animation.Translate(0, -clue_height)],
                    curve="ease_in_out",
                  ),
                ],
                child=render.Box(
                  color=background_color,
                  child=render.Marquee(
                    scroll_direction="vertical",
                    offset_start=clue_height,
                    height=clue_height,
                    width=const.WIDTH,
                    child=render.WrappedText(
                      clue,
                      width=const.WIDTH,
                      align="center",
                      font="tom-thumb"
                    )
                  )
                )
              )
            ]
          )
        ]
      )
    )
  )
