resource "google_compute_instance" "terraform-instance" {
	name = "client-node-1"
	machine_type = "e2-medium"
	zone = "us-central1-a"
	labels = {
	  team = "devops"
	  depart = "hr"
	}
	boot_disk {
          initialize_params {
          image = "ubuntu-os-cloud/ubuntu-2204-lts"
                             }
                   }
	network_interface {
	  network = "projects/devops-engineer-123/global/networks/my-vpc-01"
	  subnetwork = "projects/devops-engineer-123/regions/us-central1/subnetworks/subnet-01"
        access_config {
                    }
}


}

#------Extra Disk to VM Instance-----#

resource "google_compute_disk" "data-disk-01" {
	name = "data-disk-01"
	zone = "us-central1-a"
	size = "10"
	type = "pd-standard"
}

#------Attach Disk-----#

resource "google_compute_attached_disk" "disk-attach-policy" {
	disk = google_compute_disk.data-disk-01.id
	instance = google_compute_instance.terraform-instance.name
	zone = "us-central1-a"
}
