resource "google_compute_instance" "private_vm_instance" {
  name         = "private-vm-instance"
  machine_type = "e2-micro"
  zone         = "europe-west1-b"
  allow_stopping_for_update = true

  depends_on = [
    google_container_cluster.private-cluster
   , google_container_node_pool.nodepool
  ]

  #Try to automate installing kubectl and gcloud auth and get the gke credentials  and configure the user to use kubctl 
  #Then, configure the cluster

   metadata_startup_script = <<-EOF
                                #
                                sudo mkdir kube_files
                                sudo yum install kubectl -y
                                sudo yum install google-cloud-sdk-gke-gcloud-auth-plugin -y
                                sudo gcloud container clusters get-credentials private-standerd-gke-cluster --zone europe-west1-b
                                sudo cp -r /root/.config/ /home/m3brazik/
                                sudo chown -R m3brazik:m3brazik /home/m3brazik/.config/
                                sudo cp -r /root/.kube/ /home/m3brazik/
                                sudo chown -R m3brazik:m3brazik /home/m3brazik/.kube/
                                  EOF

  boot_disk {
    initialize_params {
      image = "centos-cloud/centos-7"
      size = 20
    
    }
  }
 
  network_interface {
    network = module.network.vpc_name_output
    subnetwork = module.network.subnet_1_name_output
  }
  service_account {
        email = google_service_account.instance_service_account.email
        scopes = [ "cloud-platform" ] #See, edit, configure, and delete your Google Cloud data and see the email address for your Google Account.
}

}