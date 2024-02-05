import 'package:mmlearning_admin/home/data/category_data_course.dart';
import 'package:mmlearning_admin/home/data/course_data_source.dart';
import 'package:mmlearning_admin/home/data/discount_data_source.dart';
import 'package:mmlearning_admin/home/data/enrollment_data_source.dart';
import 'package:mmlearning_admin/home/data/rating_data_source.dart';
import 'package:mmlearning_admin/home/data/review_data_source.dart';
import 'package:mmlearning_admin/home/data/slider_data_source.dart';
import 'package:mmlearning_admin/home/data/student_data_source.dart';
import 'package:mmlearning_admin/model/admin_enrolled_student.dart';
import 'package:mmlearning_admin/model/category.dart';
import 'package:mmlearning_admin/model/course.dart';
import 'package:mmlearning_admin/model/discount.dart';
import 'package:mmlearning_admin/model/rating.dart';
import 'package:mmlearning_admin/model/review.dart';
import 'package:mmlearning_admin/model/student.dart';
import 'package:mmlearning_admin/model/user.dart';
import 'package:mmlearning_admin/slider/model/slider.dart';

final courseDataSource = CourseDataSource(
  courses: List.generate(
    100,
    (index) => Course(
      featured: false,
      categoryId: 0,
      id: index,
      title: "Test Title For Development $index",
      image: "",
      price: 50000,
      reviewsCount: 100,
      averageRatings: 3.5,
      enrollStudentsCount: 200,
    ),
  ),
);
final categoryDataSource = CategoryDataSource(
  courses: List.generate(
      100,
      (index) => Category(
          id: index,
          title: "Category Name For Testing Development",
          image: "https://cdn-icons-png.flaticon.com/128/4730/4730727.png",
          coursesCount: 5)),
);
final discountDataSource = DiscountDataSource(
  courses: List.generate(
    10,
    (index) => Discount(
      id: index,
      title: "Discount Test Title $index",
      image:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT_lAVf7hk4kDrKM4XjxqxOORLzQ4R7zfrKRkOu4ZQ2dA&s",
      discountPercentage: 50,
    ),
  ),
);
final studentDataSource = StudentDataSource(
    courses: List.generate(
        100,
        (index) => Student(
            id: index,
            membership: "B",
            enrolledCourses: 3,
            user: User(
                id: index,
                username: "-",
                firstName: "Test User",
                lastName: "Name",
                email: 'test@gmail.com'))));
final sliderDataSource = SliderDataSource(
  courses: List.generate(
    100,
    (index) => Slider(
      id: index,
      title: "Slier Title Test Development",
      image: "https://cdn-icons-png.flaticon.com/128/4896/4896338.png",
    ),
  ),
);
final ratingDataSource = RatingDataSource(
  courses: List.generate(
    100,
    (index) => Rating(
        rating: 3.5,
        student: Student(
          enrolledCourses: 3,
          id: index,
          membership: "B",
          user: User(
            id: index,
            firstName: "Test User",
            lastName: "Name",
            username: "-",
            email: "test@gmail.com",
          ),
        ),
        course: Course(
          id: index,
          categoryId: 0,
          featured: false,
          title: "Test Course Name",
          image: "",
        )),
  ),
);
final reviewDataSource = ReviewDataSource(
  courses: List.generate(
    100,
    (index) => Review(
        review: "Review Test 'This is best course ever'",
        course: Course(
          id: index,
          featured: false,
          categoryId: 0,
          title: "Test Course Name",
          image: "",
        ),
        student: Student(
          enrolledCourses: 4,
          id: index,
          membership: "B",
          user: User(
            id: index,
            firstName: "Test User",
            lastName: "Name",
            username: "-",
            email: "test@gmail.com",
          ),
        ),
        rating: 2.3,
        date: DateTime.now()),
  ),
);
final enrollmentDataSource = EnrollmentDataSource(
    courses: [] /* List.generate(
    100,
    (index) => AdminEnrolledStudent(
      course: Course(
        id: index,
        title: "Test Course Name",
        image: "",
      ),
      student: Student(
        id: index,
        membership: "B",
        user: User(
          id: index,
          firstName: "Test User",
          lastName: "Name",
          username: "-",
          email: "test@gmail.com",
        ),
      ),
      subscribedCount: 2,
      subscribed: true,
      expirationDate: DateTime.now().toIso8601String(),
    ),
  ),
 */
    );

List<String> students = [
  "Cersei lannister",
  "John Snow",
  "Arya Stark",
  "Bran Stark",
];
List<String> courses = [
  "Project Management",
  "PMBook (Sixth Edition) Pdf",
  'Nurse Aid & Caregiver Course',
  'Agile Software Development: Practices for Efficient Project Management',
  'Data Security and Privacy in Software Development',
  'Machine Learning Fundamentals: Algorithms and Applications',
  'Deep Learning Architectures: Neural Networks and Beyond',
];
List<String> categories = [
  "IT & Development",
  "Nurse Trainning",
  "Project Management",
  "Design"
];
List<String> sections = [
  'Introduction to Project Management',
  'Project Initiation and Planning',
  'Project Scheduling',
  'Budgeting and Cost Management',
  'Quality Management',
  'Risk Management',
  'Human Resource Management',
  'Procurement and Contract Management',
  'Project Execution and Monitoring',
  'Project Closure and Post-Project Evaluation',
];
List<String> lessons = [
  'Overview of project management',
  'Key concepts and terminologies',
  'The role of a project manager',
  'Project management methodologies (e.g., Agile, Waterfall, PRINCE2)',
  'Defining project scope and objectives',
  'Stakeholder analysis and engagement',
  'Creating a project charter',
  'Developing a project management plan',
];
