import 'package:app/parameters.dart';
import 'package:flutter/material.dart';

class TermsWidget extends StatelessWidget {
  const TermsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.buttonColor,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Terms of Use',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              SizedBox(
                height: 20,
              ),
              // Текст соглашения
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis in nisl at eros efficitur dapibus. Sed vel nunc vel metus feugiat feugiat eu vel ipsum. Nulla facilisi. Nullam auctor purus id fringilla mollis. Sed ut ante ipsum. Vestibulum rhoncus, ligula quis tincidunt cursus, libero sem vestibulum odio, nec mollis mauris metus eu metus. Nulla facilisi. Sed eu lacus posuere, ultrices metus eget, varius arcu. Fusce nec hendrerit quam. Sed et metus vitae tortor convallis vulputate. Nunc auctor elementum nibh, at tristique turpis luctus vel. Vestibulum at ipsum non purus euismod imperdiet. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec mauris sem, tempor quis placerat at, rutrum nec lorem. Donec nec mi aliquam, tempor enim at, ornare lacus. Proin feugiat ligula ac sem fermentum, ac feugiat nunc dapibus."
                  "Phasellus auctor, urna nec semper condimentum, urna tortor interdum sem, a maximus lectus eros at tellus. Sed at mi a ipsum pharetra tempor. Nullam in magna non magna gravida fringilla. Aenean eget ipsum nec est ultrices convallis. Sed dignissim tellus in ligula iaculis, vel ullamcorper velit feugiat. Nam bibendum elit sed pharetra aliquam. Donec vel commodo neque. Mauris mollis dapibus est, vitae tristique purus interdum a. Sed pharetra lectus a sapien pretium, ut faucibus lacus maximus. Aenean tincidunt tortor eget dui hendrerit, eu fermentum mi lacinia. Proin pharetra dolor quis arcu rhoncus, a consequat lectus fermentum.",
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}

class PolicyWidget extends StatelessWidget {
  const PolicyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: AppColors.buttonColor,
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
              ),
              SizedBox(
                height: 20,
              ),
              // Текст политики
              Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis in nisl at eros efficitur dapibus. Sed vel nunc vel metus feugiat feugiat eu vel ipsum. Nulla facilisi. Nullam auctor purus id fringilla mollis. Sed ut ante ipsum. Vestibulum rhoncus, ligula quis tincidunt cursus, libero sem vestibulum odio, nec mollis mauris metus eu metus. Nulla facilisi. Sed eu lacus posuere, ultrices metus eget, varius arcu. Fusce nec hendrerit quam. Sed et metus vitae tortor convallis vulputate. Nunc auctor elementum nibh, at tristique turpis luctus vel. Vestibulum at ipsum non purus euismod imperdiet. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Donec mauris sem, tempor quis placerat at, rutrum nec lorem. Donec nec mi aliquam, tempor enim at, ornare lacus. Proin feugiat ligula ac sem fermentum, ac feugiat nunc dapibus."
                  "Phasellus auctor, urna nec semper condimentum, urna tortor interdum sem, a maximus lectus eros at tellus. Sed at mi a ipsum pharetra tempor. Nullam in magna non magna gravida fringilla. Aenean eget ipsum nec est ultrices convallis. Sed dignissim tellus in ligula iaculis, vel ullamcorper velit feugiat. Nam bibendum elit sed pharetra aliquam. Donec vel commodo neque. Mauris mollis dapibus est, vitae tristique purus interdum a. Sed pharetra lectus a sapien pretium, ut faucibus lacus maximus. Aenean tincidunt tortor eget dui hendrerit, eu fermentum mi lacinia. Proin pharetra dolor quis arcu rhoncus, a consequat lectus fermentum.",
                  style: TextStyle(fontSize: 20)),
            ],
          ),
        ),
      ),
    );
  }
}
