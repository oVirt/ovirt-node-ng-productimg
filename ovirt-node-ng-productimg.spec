Name:           ovirt-node-ng-productimg
Version:        4.5.0
Release:        0%{?dist}
Summary:        oVirt Node NG Anaconda branding

License:        GPLv2
URL:            https://github.com/oVirt/ovirt-node-ng-productimg
Source0:        https://github.com/oVirt/%{name}/releases/download/%{name}-%{version}/%{name}-%{version}.tar.gz

BuildArch:      noarch
BuildRequires:  make
BuildRequires:  pigz


%description
oVirt Node NG Anaconda branding

%prep
%setup -c -q


%build
make

%install
/usr/bin/install -d %{buildroot}/%{_datadir}/ovirt-node-ng-image-update/image
/usr/bin/install -m 644 product.img %{buildroot}/%{_datadir}/ovirt-node-ng-image-update/image/product.img


%files
%{_datadir}/ovirt-node-ng-image-update/image/product.img
%license LICENSE
%doc README.md

%changelog
* Fri Mar 25 2022 Sandro Bonazzola <sbonazzo@redhat.com> - 4.5.0-0
- Initial packaging
