const profileData = {
  title: "Resume",
  name: "Edward Xu",
  logoURL: "assets/images/dp.jpg",
  about: {
    contact: {
      email: "e43xu@uwaterloo.ca",
    },
  },
  links: [
    {
      title: "LinkedIn",
      src: "https://www.linkedin.com/in/edwardhbxu",
      iconClass: "fa-brands fa-linkedin-in",
    },
    {
      title: "Github",
      src: "https://github.com/edwardhbxu",
      iconClass: "fa-brands fa-github",
    },
  ],
  skills: [
    {
      title: "Languages",
      value: "Python, C, C++, Bash, JavaScript, HTML, Git, Groovy, R",
    },
    {
      title: "Technologies",
      value: "GitHub Actions, AWS, GCP, Azure, Kubernetes, Terraform, Ansible, Jenkins, GitHub, Linux",
    },
  ],
  experiences: [
    {
      organization: "Nautical Commerce",
      title: "Platform Engineer",
      date: "May 2024 - Aug 2024",
      details: [
        `Administrated, debugged and resolved issues within Kubernetes clusters, leveraged GitHub Actions to automate cluster deployments to GKE`,
        `Identified cost-saving opportunities in GKE by analyzing resource utilization and optimizing configurations, implemented GitHub Actions workflows to scale trial environments, allowing cost-effective scaling from full capacity to zero and back`,
        `Developed and deployed a secure HTML site on GCP to provide comprehensive information on all company environments. Implemented JavaScript requests and configured CORS settings, along with GitHub Actions workflows to automate site content updates`,
      ],
    },
    {
      organization: "FundSERV Inc",
      title: `DevOps Engineer`,
      date: "Sep 2023 - Dec 2023",
      details: [
        `Implemented a GitHub Actions workflow to automate Java application deployments across diverse projects within the company. Enhanced with configuration parsing, testing, HashiCorp Vault integration and efficient Gradle builds to produce an RPM package and deploy with Ansible`,
        `Integrated Azure Logic Apps, Azure Functions and API connections to automate the Royal Bank of Canada (RBC) encrypted payment file transfer system. Implemented Azure Key Vault and access policies to ensure secure key management for efficient and secure file transfers`,
        `Leveraged Terraform to deploy the RBC payment file transfer system as code`,
      ],
    },
    {
      organization: "Imagine Communications Corp",
      title: `DevOps Software Developer`,
      date: "Jan 2023 - Apr 2023",
      details: [
        `Researched, developed, and executed Jenkins server migration using Bash to improve migration speed by 400% relative to older migration scripts`,
        `Automated server upgrades using Ansible, PowerShell, Bash and Jinja, accelerating the video server upgrade procedure`,
      ],
    },
    {
      organization: "Ontario Ministry of Transportation",
      title: `Junior Technical Analyst`,
      date: "May 2022 - Aug 2022",
      details: [
        `Researched, documented, and carried out Azure DevOps organization level project migrations using Chocolatey and PowerShell, communicated with client and business teams to meet expectations`,
        `Onboarded the Qualys Defender to Log Analytics Workspaces on Azure Portal`,
      ],
    },
  ],
  projects: [
    {
      title: "Cloud Resume Challenge",
      duration: "Aug - Sep 2024",
      link: "https://github.com/edwardhbxu",
      desc: `Hosted a serverless web application on AWS, leveraging S3, CloudFront, Route53, Lambda, API Gateway, DynamoDB, and IAM to create a personal resume site. Implemented GitHub Actions pipelines and Terraform to automate future deployments`,
    },
    {
      title: "Chamber Crawler 3000 Game",
      duration: "Jul - Aug 2023",
      desc: `Developed a dungeon-crawling game in C++ containing random floor generation, multiple floors and enemy movement along with diverse classes for both player and enemies. Leveraged OOP principles including abstraction, encapsulation, and inheritance`,
    },
  ],
  education: [
    {
      alma: "University of Waterloo",
      duration: "Sep 2021 - Apr 2026",
      std: "Candidate for Bachelor of Mathematics, Computational Mathematics",
    },
  ],
};
