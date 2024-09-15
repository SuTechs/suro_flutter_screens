import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PetHomeScreen extends StatelessWidget {
  const PetHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
            child: Icon(
              Icons.menu_rounded,
              color: kBrownColor,
            ),
          ),
        ),
        title: const Text('Luka'),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(kDummyProfilePicUrl),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          /// Location Picker
          const LocationPicker(),
          const SizedBox(height: 16),

          /// category
          PetCategoryTabBar(
            categories: CategoryData.categories,
            onTabChanged: (index) {},
          ),
          const SizedBox(height: 24),

          /// pet list
          const Expanded(
            child: PetGridList(
              pets: [...PetData.cats],
            ),
          ),
        ],
      ),
    );
  }
}

/// Pet Grid List
class PetGridList extends StatelessWidget {
  final List<PetData> pets;

  const PetGridList({super.key, required this.pets});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: pets.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 185 / 250,
      ),
      itemBuilder: (context, index) {
        return PetGridTile(
          pet: pets[index],
        );
      },
    );
  }
}

/// Pet Grid Tile
class PetGridTile extends StatelessWidget {
  final PetData pet;

  const PetGridTile({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PetDetailsScreen(pet: pet),
          ),
        );
      },
      child: Hero(
        tag: pet.imageUrl,
        child: Card(
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.red,
              gradient: const LinearGradient(
                colors: [
                  Colors.black12,
                  Colors.black54,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(14),
              image: DecorationImage(
                image: NetworkImage(pet.imageUrl),
                fit: BoxFit.contain,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // name
                Text(
                  pet.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // breed
                Text(
                  pet.breed,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // gender and age
                Row(
                  children: [
                    // gender icon
                    Icon(
                      pet.isGenderMale ? Icons.male : Icons.female,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      pet.isGenderMale ? 'Boy' : 'Girl',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    const Icon(
                      Icons.access_time_outlined,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      pet.age,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Category Tile
class CategoryTile extends StatelessWidget {
  final CategoryData data;
  final bool isSelected;

  const CategoryTile({
    super.key,
    this.isSelected = false,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // icon
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: isSelected ? kLinearGradient : null,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Center(
            child: SvgPicture.network(
              data.iconPath,
              height: 28,
              width: 28,
              colorFilter: ColorFilter.mode(
                isSelected ? Colors.white : kGreyTextColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),

        // text
        Text(
          data.title,
          style: TextStyle(
            color: isSelected ? kPrimaryColor : kGreyTextColor,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

/// Pet Category Tab Bar
class PetCategoryTabBar extends StatefulWidget {
  final List<CategoryData> categories;
  final void Function(int index) onTabChanged;

  const PetCategoryTabBar({
    super.key,
    required this.categories,
    required this.onTabChanged,
  });

  @override
  State<PetCategoryTabBar> createState() => _PetCategoryTabBarState();
}

class _PetCategoryTabBarState extends State<PetCategoryTabBar> {
  int _selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (int i = 0; i < widget.categories.length; i++)
          GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = i;
              });
              widget.onTabChanged(i);
            },
            child: CategoryTile(
              data: widget.categories[i],
              isSelected: i == _selectedIndex,
            ),
          ),
      ],
    );
  }
}

/// Location Picker
class LocationPicker extends StatelessWidget {
  const LocationPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: Icon(Icons.location_on_outlined, color: kGreyTextColor),
      title: Text(
        'Benagluru, India',
        style: TextStyle(color: kGreyTextColor),
      ),
    );
  }
}

// ------------------ Pet Details Screen ------------------

class PetDetailsScreen extends StatelessWidget {
  final PetData pet;

  const PetDetailsScreen({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPinkishColor,
      body: CustomScrollView(
        slivers: [
          // pet image
          SliverAppBar(
            forceMaterialTransparency: true,
            expandedHeight: 400,
            flexibleSpace: FlexibleSpaceBar(
              background: Hero(
                tag: pet.imageUrl,
                child: Image.network(
                  pet.imageUrl,
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.favorite_border,
                  color: kPrimaryColor,
                ),
                onPressed: () {},
              ),
            ],
          ),

          // pet details
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                color: kBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  /// indicator
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: kGreyTextColor.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),

                  /// pet details info
                  PetDetailsInfoCard(pet: pet),
                  const SizedBox(height: 32),

                  /// Owner Info Card
                  const OwnerInfoCard(),
                  const SizedBox(height: 8),

                  /// description
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      kDummyDescription,
                      style: TextStyle(
                        color: kGreyTextColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.all(16),
        height: 48,
        decoration: BoxDecoration(
          gradient: kLinearGradient,
          borderRadius: BorderRadius.circular(24),
        ),
        child: const Center(
          child: Text(
            'ADOPT NOW',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

class OwnerInfoCard extends StatelessWidget {
  const OwnerInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white,
      ),
      child: Row(
        children: [
          /// owner photo
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: kPrimaryColor, width: 2),
              image: const DecorationImage(
                image: NetworkImage(kDummyProfilePicUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(width: 16),

          /// owner name
          RichText(
            text: const TextSpan(
              text: 'OWNED BY\n',
              style: TextStyle(
                color: kGreyTextColor,
                fontSize: 12,
              ),
              children: [
                TextSpan(
                  text: 'Rohan Patil',
                  style: TextStyle(
                    color: kBrownColor,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),

          /// contact button

          const Spacer(),

          /// message button
          const ContactActionButton(icon: Icons.message),
          const SizedBox(width: 16),

          /// call button
          const ContactActionButton(icon: Icons.call),
        ],
      ),
    );
  }
}

class ContactActionButton extends StatelessWidget {
  final IconData icon;

  const ContactActionButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: 42,
      decoration: BoxDecoration(
        color: const Color(0xffF2F2F2),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Icon(
        icon,
        color: kPrimaryColor,
      ),
    );
  }
}

class CustomInfographic extends StatelessWidget {
  final Color color;
  final String title;
  final String value;

  const CustomInfographic({
    super.key,
    required this.color,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 32,
          width: 4,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: kGreyTextColor,
                fontSize: 12,
              ),
            ),
            Text(
              value,
              style: const TextStyle(
                color: kBrownColor,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PetDetailsInfoCard extends StatelessWidget {
  final PetData pet;

  const PetDetailsInfoCard({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        /// Pet basic info
        ListTile(
          /// name
          title: Text(pet.name),
          titleTextStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: kBrownColor,
          ),

          /// location
          subtitle: const Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: kGreyTextColor,
                size: 16,
              ),
              SizedBox(width: 4),
              Text(
                'Bengaluru (3.2km)',
                style: TextStyle(
                  color: kGreyTextColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),

          /// price
          trailing: const Text(
            '₹3,000',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 24,
            ),
          ),
        ),

        /// Pet more details
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white,
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// sex
              CustomInfographic(
                color: kPrimaryColor,
                title: 'Sex',
                value: 'Male',
              ),

              /// Age
              CustomInfographic(
                color: Color(0xffF78F8F),
                title: 'Age',
                value: '1 year',
              ),

              /// Weight
              CustomInfographic(
                color: Color(0xffF4D757),
                title: 'Weight',
                value: '2 kg',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ------------------ Data Models & Constants ------------------

/// Pet Data Model [data.dart]
class PetData {
  final String name;
  final String imageUrl;
  final String breed;
  final String age;
  final bool isGenderMale;

  const PetData({
    required this.name,
    required this.imageUrl,
    required this.breed,
    required this.age,
    required this.isGenderMale,
  });

  static const cats = [
    PetData(
      name: 'Mia',
      breed: 'Burmilla',
      isGenderMale: false,
      age: '2 months',
      imageUrl:
          'https://raw.githubusercontent.com/SuTechs/pet_adoption/master/assets/images/cat1.png',
    ),
    PetData(
      name: 'Oliver',
      breed: 'Australian Mist',
      isGenderMale: true,
      age: '1 year',
      imageUrl:
          'https://raw.githubusercontent.com/SuTechs/pet_adoption/master/assets/images/cat2.png',
    ),
    PetData(
      name: 'Jerry',
      breed: 'Scottish Fold',
      isGenderMale: false,
      age: '2 year',
      imageUrl:
          'https://raw.githubusercontent.com/SuTechs/pet_adoption/master/assets/images/cat3.png',
    ),
    PetData(
      name: 'Milo',
      breed: 'American Curl',
      isGenderMale: false,
      age: '1 months',
      imageUrl:
          'https://raw.githubusercontent.com/SuTechs/pet_adoption/master/assets/images/cat4.png',
    ),
  ];
}

class CategoryData {
  final String title;
  final String iconPath;

  const CategoryData({
    required this.title,
    required this.iconPath,
  });

  static const List<CategoryData> categories = [
    CategoryData(
      title: 'Dogs',
      iconPath:
          'https://raw.githubusercontent.com/SuTechs/pet_adoption/4273415376aaddadbee4e4c6b392c69a13ed3b3c/assets/icons/dog.svg',
    ),
    CategoryData(
      title: 'Cats',
      iconPath:
          'https://raw.githubusercontent.com/SuTechs/pet_adoption/4273415376aaddadbee4e4c6b392c69a13ed3b3c/assets/icons/cat.svg',
    ),
    CategoryData(
      title: 'Birds',
      iconPath:
          'https://raw.githubusercontent.com/SuTechs/pet_adoption/4273415376aaddadbee4e4c6b392c69a13ed3b3c/assets/icons/bird.svg',
    ),
    CategoryData(
      title: 'Rabbits',
      iconPath:
          'https://raw.githubusercontent.com/SuTechs/pet_adoption/4273415376aaddadbee4e4c6b392c69a13ed3b3c/assets/icons/rabbit.svg',
    ),
    CategoryData(
      title: 'Hamsters',
      iconPath:
          'https://raw.githubusercontent.com/SuTechs/pet_adoption/4273415376aaddadbee4e4c6b392c69a13ed3b3c/assets/icons/hamster.svg',
    ),
  ];
}

/// Constants and Colors [constants.dart]

const kPrimaryColor = Color(0xFFFD9340);
const kSecondaryColor = Color(0xFFFF6767);

const kGreyTextColor = Color(0xFF948A82);
const kBrownColor = Color(0xFF5A3518);

const kBackgroundColor = Color(0xFFF5F5F5);

const kPinkishColor = Color(0xFFFFF4EB);

const kLinearGradient = LinearGradient(
  colors: [kPrimaryColor, kSecondaryColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);

const kDummyProfilePicUrl =
    'https://images.unsplash.com/photo-1599842057874-37393e9342df?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

const kDummyDescription =
    "Cras sit amet interdum turpis. In nec pulvinar mauris. Curabitur erat tortor, posuere sodales ante sed, accumsan ullamcorper nisi. Cras consequat nisl magna, nec maximus nisi semper mattis.";
