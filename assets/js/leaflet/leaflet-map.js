import L from 'leaflet'

const template = document.createElement('template');
template.innerHTML = `
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.7.1/dist/leaflet.css"
    integrity="sha512-xodZBNTC5n17Xt2atTPuE1HxjVMSvLVW9ocqUKLsCC5CXdbqCmblAshOMAS6/keqq/sMZMZ19scR4PsZChSR7A=="
    crossorigin=""/>
    <div style="height: 500px;">
        <slot />
    </div>
`

class LeafletMap extends HTMLElement {
    constructor() {
        super();

        this.attachShadow({ mode: 'open' });
        this.shadowRoot.appendChild(template.content.cloneNode(true));
        this.mapElement = this.shadowRoot.querySelector('div')

        this.map = L.map(this.mapElement).setView([this.getAttribute('lat'), this.getAttribute('lng')], 4.2);
        L.tileLayer('https://api.mapbox.com/styles/v1/{id}/tiles/{z}/{x}/{y}?access_token=pk.eyJ1IjoiYWx0am9obmRldiIsImEiOiJja2hlOTlyYnEwYWxpMnhveHFyMXUyY3Q1In0.XWYAWJv0dkL_9iB8b4v9yQ', {
            attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors, <a href="https://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="https://www.mapbox.com/">Mapbox</a>',
            maxZoom: 18,
            id: 'mapbox/streets-v11',
            tileSize: 512,
            zoomOffset: -1
        }).addTo(this.map);
    }

    connectedCallback() {
        const markerElements = this.querySelectorAll('leaflet-marker')
        markerElements.forEach(markerEl => {

            let numberIcon = L.divIcon({
                className: "number-icon",
                iconSize: [25, 41],
                iconAnchor: [7.9, 44],
                popupAnchor: [3, -40],
                html: markerEl.getAttribute('number')
            });
            let pinIcon = L.icon({
                iconUrl: '/images/marker-hole.svg',
                iconSize: [25, 41],
                iconAnchor: [15, 48],
                popupAnchor: [3, -40],
            });
                        
            const lat = markerEl.getAttribute('lat')
            const lng = markerEl.getAttribute('lng')
            L.marker([lat, lng], { icon:  pinIcon }).addTo(this.map);
            const leafletMarkerNumber = L.marker([lat, lng], { icon:  numberIcon }).addTo(this.map);
            leafletMarkerNumber.addEventListener('click', (_event) => {
                window.location.href = markerEl.getAttribute('link')
            })
        })
    }
}

window.customElements.define('leaflet-map', LeafletMap);