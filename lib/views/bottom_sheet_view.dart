import 'dart:ui';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../models/app_colors.dart';
import '../models/app_images.dart';
import '../controller/music_controller.dart';

class BottomSheetMusic extends StatefulWidget {
  final int imageIndex;
  final List<String> imagesPathList;

  const BottomSheetMusic(
      {super.key, required this.imageIndex, required this.imagesPathList});

  @override
  State<BottomSheetMusic> createState() => _BottomSheetMusicState();
}

class _BottomSheetMusicState extends State<BottomSheetMusic> {
  final carouselSliderController = CarouselController();
  final musicController = Get.put(MusicController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          const SizedBox(
            width: 50,
            child: Divider(
              height: 30,
              color: AppColors.dividerColor,
              thickness: 4,
            ),
          ),
          Text(
            'Musik yang anda dengar',
            style: TextStyle(
                color: Theme.of(context).colorScheme.tertiary, fontSize: 14),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 320,
            width: 350,
            //width: 320,
            decoration: BoxDecoration(
              //color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: CarouselSlider.builder(
              itemCount: widget.imagesPathList.length,
              itemBuilder: (context, index, realIndex) {
                return Stack(
                  //clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      top: -10,
                      bottom: 20,
                      left: 40,
                      right: 40,
                      child: Container(
                        height: 220,
                        width: 280,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: AssetImage(widget.imagesPathList[index]),
                              fit: BoxFit.fill),
                        ),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            color: Colors.black.withOpacity(0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 285,
                      width: 350,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          widget.imagesPathList[index],
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ],
                );
              },
              carouselController: carouselSliderController,
              options: CarouselOptions(
                height: double.infinity,
                //height: 400,
                initialPage: widget.imageIndex,
                reverse: false,
                autoPlay: false,
                enlargeCenterPage: true,
                viewportFraction: 1, // to display full item
              ),
            ),
          ),
          Obx(
            () {
              return RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: (musicController.songName.value == 'null' ||
                              musicController.songName.value == '')
                          ? "unknown\n"
                          : "${musicController.songName}\n",
                      style: TextStyle(
                        fontSize: 22,
                        color: Theme.of(context).colorScheme.tertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const WidgetSpan(
                      child: SizedBox(
                        height: 20,
                      ),
                    ),
                    TextSpan(
                      text: (musicController.albumName.value == 'null' ||
                              musicController.albumName.value == '')
                          ? "unknown\n"
                          : "${musicController.albumName}",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          Expanded(
            flex: 0,
            child: SliderTheme(
              data: SliderThemeData(
                trackHeight: 6,
                thumbShape: CustomThumbShape(),
              ),
              child: Container(
                height: 15,
                margin: const EdgeInsets.only(top: 20),
                child: Obx(
                  () {
                    return Slider(
                      activeColor: AppColors.bottomNavigationIconColor,
                      inactiveColor: AppColors.sliderInactiveColor,
                      value: musicController.currentPosition.value.inSeconds
                          .toDouble(),
                      min: 0,
                      max: musicController.audioDuration.value.inSeconds
                          .toDouble(),
                      onChanged: (value) {
                        musicController.seekAudio(value);
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Obx(
              () {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      musicController.formatTime(
                          musicController.currentPosition.value.inSeconds),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    Text(
                      musicController.formatTime(
                          musicController.audioDuration.value.inSeconds),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        musicController.stopAndPlayMusic();
                        carouselSliderController.previousPage();
                      },
                      icon: const Icon(
                        Icons.skip_previous_rounded,
                        size: 40,
                        color: AppColors.musicButtonColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        musicController.back10Sec();
                      },
                      icon: const Icon(
                        Icons.replay_10_rounded,
                        size: 30,
                        color: AppColors.musicButtonColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: PhysicalShape(
                      color: Colors.transparent,
                      shadowColor: AppColors.gradientButtonColor2,
                      elevation: 12,
                      clipper: const ShapeBorderClipper(shape: CircleBorder()),
                      child: InkWell(
                        onTap: () {
                          musicController.playMusic();
                        },
                        child: Container(
                          height: 60,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.gradientButtonColor1,
                                AppColors.gradientButtonColor2
                              ],
                            ),
                          ),
                          child: Transform.scale(
                            scale: 0.65,
                            child: Obx(
                              () {
                                return SvgPicture.asset(
                                  musicController.isPlaying.value
                                      ? AppImages.pauseIcon
                                      : AppImages.playIcon,
                                  colorFilter: const ColorFilter.mode(
                                      Colors.white, BlendMode.srcIn),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        musicController.forward10Sec();
                      },
                      icon: const Icon(
                        Icons.forward_10_rounded,
                        size: 30,
                        color: AppColors.musicButtonColor,
                      ),
                    ),
                  ),
                  Expanded(
                    child: IconButton(
                      onPressed: () {
                        musicController.stopAndPlayMusic();
                        carouselSliderController.nextPage();
                      },
                      icon: const Icon(
                        Icons.skip_next_rounded,
                        size: 40,
                        color: AppColors.musicButtonColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Expanded(
            flex: 0,
            child: Divider(
              color: AppColors.dividerColor2,
              thickness: 3,
            ),
          ),
          Expanded(
            flex: 0,
            child: Container(
              height: 80,
              padding: const EdgeInsets.only(
                left: 30,
                right: 30,
              ),
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              //alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppImages.saveIcon,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                          AppColors.musicButtonColor, BlendMode.srcIn),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppImages.uploadIcon,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                          AppColors.musicButtonColor, BlendMode.srcIn),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset(
                      AppImages.moreIcon,
                      height: 30,
                      colorFilter: const ColorFilter.mode(
                          AppColors.musicButtonColor, BlendMode.srcIn),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomThumbShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return const Size.fromRadius(8); // Set the desired thumb radius
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;
    final thumbPaintOuter = Paint()..color = Colors.white;
    final thumbPaintInner = Paint()..color = sliderTheme.thumbColor!;

    canvas.drawCircle(center, 8, thumbPaintOuter);
    canvas.drawCircle(center, 5, thumbPaintInner);
  }
}
