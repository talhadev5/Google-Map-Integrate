import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tophotels/modules/resources/app_colors.dart';
import 'package:tophotels/modules/view/filter.dart';
import 'package:tophotels/modules/widgets/custom_listitems.dart';

class CustomListViewWidget extends StatelessWidget {
  final List<Map<String, dynamic>> data = [
    {
      'image':
          'https://s3-alpha-sig.figma.com/img/70bd/0f74/aea52d137388871f876f39660eb07b28?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jbY02NxE8DvAwVAJm6nAx2EYdkg0Hg3uSfCVKAODCPmPobwDLck9WEs0FiDFc7LPX-qYaVhsosrfRBIm~YPeDW8JMO5F2et2eF8dY2hxmixXAqzl40YSuEnrQpzUnlWIpYf8lNAdJ9uWUPau78XO79U~UBSUqc~EzUL0FN8M-4AlquzM1BDM2jCoF94~CsZdh6ybrIJFMiHnNDhk3dJB2yXdI7jnBaZFehNiGeAXoZgJ8V7VR8JtMf6-H9dNO5ij0XwcFePefXMEUwKrrKhc01VtsSuCV9ICI2pXD7EKvGfF2sxK33wLNnDD9KvM0Bl5antCX5Bg07WA15EqD87tDg__',
      'title': 'Camilton Bar & Food',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'High',
    },
    {
      'image':
          'https://s3-alpha-sig.figma.com/img/3278/8257/e09315b28623baa53a36d83a7cba31b0?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=E5S-0zv2XPbL7vkuIybaxpuNs7nu20b-BDE0dh49QrR2oW3hTqZot8Ox4gOLWSt1need4KeMfbF575c~XZyXGGQ-TxkuYhZf21cXsO~BYJMGPCteRpfkYw~T3cfiyXUC-bgVc93ftmUJfNDO4gTGymkgMqVQsKiMMHS2iNEGMmoxgkcZvijkoeo6ODRetfZ-PLR2l2li3~OGLJnSL0ZtphXJo7jJM5B13TyO-ys0vKK0TnO3oolfPr5M1k~a7~HV4IARJwDl9T83rq0~IZ-7SRa7O00Gy554Q-lAAuijSVWUx4wbIP4J7oNRja0c8G4N523XND~a5TLhTQBEjZ7ZaQ__',
      'title': 'Serenity Bar',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'High',
    },
    {
      'image':
          'https://s3-alpha-sig.figma.com/img/f685/36a4/92c2e8a0d382d7ee3a4dbb4b1e60c875?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=OZ-LWc0fhsh1OGmIt6~GSywfOS-c9xetTB62Ioes8B-VyUL-OmAltn5zQLCqqGnopltEtspGHZjBF83S5T8wLf6VpzHfgoo~6PKHHiJkZfO8rnbWJvgICRU0aYRXyZCvFSf3GUdlCv47G2SL9OUQQDB1a-zWfpBijrZm191m-Gi-TAHMHVi779-MMMVslPz61WoQkEniVUC6V9j5B~YemBn35nGtCRQ5FX6keTE9mnO51kxhQIjdtbVnzl2FiJFPHL3hkaifcY~oWJ6EYxYpLA7IxebrKccOVyqFfbXHex2RuPU4Nuamt2ONc4HiZxvUbaubXV9o4XgobqFaPjbd0A__',
      'title': 'Mucks Cocktail Bar',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'High',
    },
    {
      'image':
          'https://s3-alpha-sig.figma.com/img/a5ae/c79b/27ead86454bf5cea09050cbf8af85434?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=LvZwHz9vATPKsRLEhjTFmYWGjDqze52afgR9TfJ51~PtsvC-OOdJ5bJ8d8T5wxICRM1lEd4UD29CdXusJ7rdgo65Iobibk9K1Gkc7yKMkUEGHrPH3yCizrSQCb-6x7-WlAMShN1TP26JUDsCgBbuPdbjmsX~Ml5-co9F~ovREjx0nDgft3wPU5jm1QN9nYl47hZvpHCKHrURrP-Iqjzv2AykUHDcoH79zkEBqfCe7XqmLsNqLx1V7qmdJ3hv6eQ9BvMVRWy5QLV9CTtTNCz6WKe8-ucmpsxkfzi1zZQJBGwW-NyFuUfSmilY0YlZqNqp4DfFQvamjVliN3EcJhFpGQ__',
      'title': 'Harry & Co',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
    {
      'image':
          'https://s3-alpha-sig.figma.com/img/ecff/8d56/bf47336beb84f41bf8dc900ef0f1c961?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=jQQOQfr~n2nONWKuvFwU0BHT9WSP3UzvRjwZbs3oOty28u6sTkNk5LwPug7FPCKg6CwCnWEWt3ABpXuLS41Fcrvz8dONhZtNAazb7i4npZfqbTZUB-yvwBKX4eaoq5dO~Tyc5e~wa0iMLo7JEhqR0Sq6jyjoz6S6ie-i1XlczxMMK3J2rL-Lm71wuFsV5WNqMig5sswUNhcYqOKMefv4twcnmIkzyxZOUYa9km-C8EkYJY6WklJ5FKTTbveYmtjRX7bcu5JtaMyomqXs83z-zEygcnFL9GnEQ89b3T5DdalaVZFCNxl4w4uLEjoYutl~Qc4fPuwIxOLMgAhSnGaZYQ__',
      'title': 'Level27',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
    {
      'image':
          'https://s3-alpha-sig.figma.com/img/a157/6c86/daef7b8b7ddffe25b49dc6c647ab09e9?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZA0JJlhMpEqvsFBw0h5ERqjKkBmeUWG25T9P4PhnbCKKCKjKrFkap3TS8-XuZPy-~xgw9r3Fj6gnAPKwsBwIo3lmGEoB0LW5eBKHXkhmxMq3J0FLvAgZtlG3pERkjGIr58umx~RTbYBEhxxfm98UxUfQOvaFFGCSSx9zkqCz3AD2g7Q-V-x2uMRJyrhmWx6D0hPpdhgaK4AW253EXtETj0x4KnoRCkeuFl38JEkylnBkpW8AuIZJ-MrwsY86AyGnzLGo2SRuHcaYOqejc6xrLTDWXEcF0CSYXaUYLxX3JZ4dFzuTmh~SJ2c3U43BuNajOC67gXsEmjD2xRXDN2mXpw__',
      'title': 'Jimmys Beer',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
    {
      'image':
          'https://s3-alpha-sig.figma.com/img/706a/df98/ca247068b2830d1cecad959208fc02af?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=IpQiwndtTQJVYyazCgkbU~P~EjHNxj4Lq6F1pNhqxUbnA4~uMNVQAMwckGNxC0sbU4iUFxpnPjZEmBRNDrr5ayzbp-hNfxtjCLRRZro-OQKROqC2C2fISN8MQAeL0A24WIy6uFZLhCRObO58EL9grDHBJJObxGjNq992lu2sTB6TCYDkYZNhXKbcvNtBm6eV-L5bA~Kug4iv3PzPzjdIRtFnfVfbMJD9qSDxYAmYIOJMjLZ8MCVBci4QKOVWVxz4cPY0lLyTNG5kx7s-qxCSVBeDB9G2Zoe5GdXUkUfD05vCemfRIK2h2Xp93HpVmwq7c8k-Dgq2lZrr8GV04lccDg__',
      'title': 'American Roots Pub',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
    {
      'image':
          'https://s3-alpha-sig.figma.com/img/1c8d/4691/7de5a2da8925786e7afadd6055fae57a?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ODNN4pfFeFa8B8QZ4IYRIqySDFa6PbX2JxS9KADlPG6owfy~tlO4tO5FZOM0-AzlDMVHra8DWerBPyBpzhPYvfRYOWOJckkP3IdyE-9IKwyDqLYZqjm5VFBzkoHAm8ufMpeDW4k84d-YDqfKy8EAcCLg-ySWXMjJVELNNSm0jK-aY5LmVZGmPgFg0Yk4LYdvvZIIt9S3jqKF23cPlOQwUQJOsB6sxX6fNruXJ5GwRDP3X0PPzJlhTYvAItpf2gtol5Ea9BBEj2kkurj3GPtz-2pYNHYTTuZ9zO8tci-5RpEowfJzX6Zx5lbKS8H3NCtpO3gyg1C7l-44dCoxbphMgQ__',
      'title': 'Devils Drinks',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
    {
      'image':
          'https://s3-alpha-sig.figma.com/img/810f/8830/79155f63c7c149442352578aafd9a83b?Expires=1736121600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=MbrHx8-loeSnJPlxADkYjQpcoMsXE6bbss~SGm6f2hLqsI0r-nFasEH7mzC8BWpv20FWwt0eDQZuAO3imQOKtyQX10ouB2Y6Ar~5tT~1LUe4TihSDjNy75ZkDXNz9kAIQPcNBFXrN1Sm3ykPgAjpzvK3Ajgq5fo7w-CCw-sKeAZTJ2FDkC2ScwGknOtEBzcLCviB-P~c9VyUo3Z2IYVmlijkPyESHSNVxlmdHLKIN0yZnuqOzmiiO-AHNLyQwpgxQXLvHa~EF6Bq~mNO~HANkCJsmPXKJnaaSlyADhyJ-APgbBnsuLryUSFLpAmjQTDu3Rr-U72cDFVZvCNw61r8Qw__',
      'title': 'Beer Bar',
      'isVerified': true,
      'rating': "Open till 9pm",
      'status': 'Normal',
    },
  ];

 CustomListViewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: Get.height * .05,
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      // Add custom label with icon and text
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            'assets/svg/mappin.and.ellipse 1.png',
                          ), // Replace with desired icon
                          const SizedBox(
                              width: 4), // Space between icon and text
                          const Text(
                            'Current location',
                            style: TextStyle(
                                color: Colors.grey), // Label text style
                          ),
                        ],
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'West House 5th, 3562 New York', // Hint text
                      hintStyle: const TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      // contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                      suffixIcon: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled:
                                  true, // Allows full-screen height
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(16)),
                              ),
                              builder: (context) => const FilterOptions(),
                            );
                          },
                          icon: SvgPicture.asset('assets/svg/filter_icon.svg')),
                    ),
                  ),
                  const Divider(),
                  const Text(
                    '42 bars found near the address',
                    style: TextStyle(color: AppColors.grey),
                  ),
                  ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(top: 10, bottom: 30),
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            CustomListItem(
                              imageUrl: data[index]['image'],
                              title: data[index]['title'],
                              isVerified: data[index]['isVerified'],
                              rating: data[index]['rating'],
                              status: data[index]['status'],
                            ),
                            const Divider(),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

